output "network_id" {
  description = "Идентификатор виртуальной сети"
  value       = yandex_vpc_network.network.id
}

output "subnet_id" {
  description = "Идентификатор подсети"
  value       = yandex_vpc_subnet.subnet.id
}

output "vm_id" {
  description = "Идентификатор виртуальной машины"
  value       = yandex_compute_instance.vm.id
}

output "vm_internal_ip" {
  description = "Внутренний IP-адрес ВМ"
  value       = yandex_compute_instance.vm.network_interface[0].ip_address
}

output "vm_external_ip" {
  description = "Публичный IP-адрес ВМ"
  value       = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}

output "static_address" {
  description = "Статический публичный IP-адрес"
  value       = yandex_vpc_address.static_address.external_ipv4_address[0].address
}