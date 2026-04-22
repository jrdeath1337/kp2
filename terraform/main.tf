# 1. Группа безопасности
resource "yandex_vpc_security_group" "vm-sg" {
  name       = "lesson-sg"
  network_id = yandex_vpc_network.network-1.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "App"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5000
  }

  ingress {
    protocol       = "TCP"
    description    = "Jenkins"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 8080
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

# 2. Виртуальная машина
resource "yandex_compute_instance" "vm" {
  name        = "lesson-vm"
  platform_id = "standard-v1"
  zone        = var.yc_zone
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params { 
      image_id = "fd87nq4mgpeo7pd7f53s" 
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.vm-sg.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
} # <-- ВОТ ЭТОЙ СКОБКИ НЕ ХВАТАЛО

# 3. Переменные и выводы
variable "ssh_public_key" {
  type = string
}

output "external_ip_address_vm" {
  value = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}

