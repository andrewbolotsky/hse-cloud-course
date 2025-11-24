resource "yandex_vpc_network" "main" {
  name   = "${var.project_name}-network"
  labels = local.project_labels
}

resource "yandex_vpc_subnet" "main" {
  name           = "${var.project_name}-subnet-${var.default_zone}"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = [var.subnet_cidr]
  labels         = local.project_labels
}

resource "yandex_vpc_security_group" "vm" {
  name        = "${var.project_name}-vm-sg"
  description = "Security group for application VM"
  network_id  = yandex_vpc_network.main.id
  labels      = local.project_labels

  ingress {
    description    = "Allow HTTP from Internet"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "Allow SSH from Internet"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Allow all outgoing traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
