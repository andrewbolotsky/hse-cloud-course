
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "app" {
  name        = "${var.project_name}-vm"
  hostname    = "${var.project_name}-vm"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = var.instance_cores
    memory        = var.instance_memory
    core_fraction = var.instance_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.instance_disk_size
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.main.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.vm.id]
  }

  metadata = {
    ssh-keys  = "${var.instance_ssh_user}:${var.ssh_public_key}"
    user-data = file("${path.module}/cloud-init.yml")
  }

  labels = local.project_labels
}
