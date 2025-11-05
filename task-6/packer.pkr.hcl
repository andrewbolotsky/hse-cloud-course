packer {
  required_plugins {
    yandex = {
      source  = "github.com/hashicorp/yandex"
      version = ">= 1.0.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.0"
    }
  }
}

variable "folder_id" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "zone" {
  type    = string
  default = "ru-central1-a"
}
variable "token" {
  type    = string
  default = ""
}
variable "service_account_key_file" {
  type    = string
  default = ""
}
variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
variable "image_family" {
  type    = string
  default = "flask-nginx-image"
}
variable "install_postgres" {
  type    = bool
  default = false
}
variable "server_name" {
  type    = string
  default = "_"
}
variable "app_port" {
  type    = number
  default = 8000
}

source "yandex" "ubuntu" {
  folder_id          = var.folder_id
  zone               = var.zone
  platform_id        = "standard-v3"
  source_image_family= "ubuntu-2204-lts"
  subnet_id          = var.subnet_id
  use_ipv4_nat       = true
  disk_size_gb       = 10

  image_name         = "flask-nginx-${formatdate("YYYYMMDD-hhmmss", timestamp())}"
  image_family       = var.image_family

  ssh_username       = "ubuntu"


  service_account_key_file = length(var.service_account_key_file) > 0 ? var.service_account_key_file : null
  token                     = length(var.token) > 0 ? var.token : null

  metadata = {
    "ssh-keys" = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}

build {
  name    = "yc-flask-nginx"
  sources = ["source.yandex.ubuntu"]

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yml"
    user          = "ubuntu"
    extra_arguments = [
      "-e", "install_postgres=${var.install_postgres}",
      "-e", "server_name=${var.server_name}",
      "-e", "app_port=${var.app_port}"
    ]
  }
}
