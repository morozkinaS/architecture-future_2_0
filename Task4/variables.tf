variable "yc_token" {
  type        = string
  description = "OAuth-токен или IAM-токен Yandex Cloud (yc iam create-token)"
  sensitive   = true
}

variable "cloud_id" {
  type        = string
  description = "Идентификатор облака Yandex Cloud (yc resource-manager cloud list)"
}

variable "folder_id" {
  type        = string
  description = "Идентификатор каталога Yandex Cloud (yc resource-manager folder list)"
}

variable "zone" {
  type        = string
  description = "Зона доступности"
  default     = "ru-central1-a"
}

# --- Сеть ---

variable "network_name" {
  type        = string
  description = "Имя виртуальной сети"
  default     = "future20-network"
}

variable "subnet_name" {
  type        = string
  description = "Имя подсети"
  default     = "future20-subnet"
}

variable "subnet_cidr" {
  type        = list(string)
  description = "CIDR-диапазон подсети"
  default     = ["10.10.0.0/24"]
}

variable "nat_gateway_name" {
  type        = string
  description = "Имя NAT-шлюза"
  default     = "future20-nat-gateway"
}

variable "route_table_name" {
  type        = string
  description = "Имя таблицы маршрутизации"
  default     = "future20-route-table"
}

variable "security_group_name" {
  type        = string
  description = "Имя группы безопасности"
  default     = "future20-security-group"
}

# --- Вычислительные ресурсы ---

variable "vm_name" {
  type        = string
  description = "Имя виртуальной машины"
  default     = "future20-vm"
}

variable "platform_id" {
  type        = string
  description = "Платформа ВМ (standard-v3 — Intel Ice Lake)"
  default     = "standard-v3"
}

variable "vm_cores" {
  type        = number
  description = "Количество vCPU"
  default     = 2
}

variable "vm_memory" {
  type        = number
  description = "Объём RAM, ГБ"
  default     = 2
}

variable "core_fraction" {
  type        = number
  description = "Гарантированная доля vCPU, % (20 — минимальная, экономия бюджета)"
  default     = 20
}

variable "disk_name" {
  type        = string
  description = "Имя загрузочного диска"
  default     = "future20-boot-disk"
}

variable "disk_type" {
  type        = string
  description = "Тип диска (network-hdd — самый дешёвый)"
  default     = "network-hdd"
}

variable "disk_size" {
  type        = number
  description = "Размер диска, ГБ"
  default     = 20
}

variable "address_name" {
  type        = string
  description = "Имя статического публичного IP-адреса"
  default     = "future20-static-address"
}

variable "ssh_public_key" {
  type        = string
  description = "Публичный SSH-ключ для доступа к ВМ (формат: ssh-rsa AAAA...)"
}