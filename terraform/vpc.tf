resource "yandex_vpc_network" "network-1" {
  name = "test-network"
}

resource "yandex_compute_instance" "vm" {
  name        = "lesson-vm"
  platform_id = "standard-v1"
  zone        = var.yc_zone  # Было "ru-central1-a"
  # ... остальное без изменений


