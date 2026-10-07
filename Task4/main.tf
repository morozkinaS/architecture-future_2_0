terraform {
  required_version = ">= 1.5"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.116.0"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

# --- Сеть ---

# Виртуальная сеть
resource "yandex_vpc_network" "network" {
  name = var.network_name
}

# Подсеть в зоне доступности
resource "yandex_vpc_subnet" "subnet" {
  name           = var.subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.subnet_cidr
  route_table_id = yandex_vpc_route_table.route_table.id
}

# NAT-шлюз для доступа в интернет из приватной подсети
resource "yandex_vpc_gateway" "nat_gateway" {
  name = var.nat_gateway_name
  shared_egress_gateway {}
}

# Таблица маршрутизации: весь исходящий трафик через NAT-шлюз
resource "yandex_vpc_route_table" "route_table" {
  network_id = yandex_vpc_network.network.id
  name       = var.route_table_name
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

# Группа безопасности: SSH (22) на вход, весь трафик на выход
resource "yandex_vpc_security_group" "security_group" {
  name       = var.security_group_name
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "SSH-доступ"
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Исходящий трафик"
  }
}

# --- Вычислительные ресурсы ---

# Образ Ubuntu 22.04 LTS (последний в семействе)
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

# Загрузочный диск
resource "yandex_compute_disk" "boot_disk" {
  name     = var.disk_name
  type     = var.disk_type
  zone     = var.zone
  size     = var.disk_size
  image_id = data.yandex_compute_image.ubuntu.id
}

# Виртуальная машина
resource "yandex_compute_instance" "vm" {
  name        = var.vm_name
  zone        = var.zone
  platform_id = var.platform_id

  resources {
    cores         = var.vm_cores
    memory        = var.vm_memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot_disk.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet.id
    security_group_ids = [yandex_vpc_security_group.security_group.id]
    nat                = true
    nat_ip_address     = yandex_vpc_address.static_address.external_ipv4_address[0].address
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

# Статический публичный IP-адрес
resource "yandex_vpc_address" "static_address" {
  name = var.address_name
  external_ipv4_address {
    zone_id = var.zone
  }
}