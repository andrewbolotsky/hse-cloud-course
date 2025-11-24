
resource "yandex_vpc_security_group" "db" {
  name        = "${var.project_name}-db-sg"
  description = "Security group for PostgreSQL database"
  network_id  = yandex_vpc_network.main.id
  labels      = local.project_labels

  ingress {
    description    = "Allow PostgreSQL from application subnet"
    protocol       = "TCP"
    port           = 5432
    v4_cidr_blocks = [var.subnet_cidr]
  }

  egress {
    description    = "Allow all outgoing traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_mdb_postgresql_cluster" "db" {
  name        = "${var.project_name}-pg"
  environment = var.db_environment
  network_id  = yandex_vpc_network.main.id

  config {
    version = var.db_version

    resources {
      resource_preset_id = var.db_resource_preset
      disk_type_id       = "network-ssd"
      disk_size          = var.db_disk_size
    }

    access {
      data_lens = true
      web_sql   = true
    }
  }

  host {
    zone             = var.default_zone
    subnet_id        = yandex_vpc_subnet.main.id
    assign_public_ip = false
  }

  security_group_ids = [yandex_vpc_security_group.db.id]

  labels = local.project_labels
}

resource "yandex_mdb_postgresql_user" "app" {
  cluster_id = yandex_mdb_postgresql_cluster.db.id
  name       = var.db_user
  password   = var.db_password
}

resource "yandex_mdb_postgresql_database" "app" {
  cluster_id = yandex_mdb_postgresql_cluster.db.id
  name       = var.db_name
  owner      = yandex_mdb_postgresql_user.app.name
}
