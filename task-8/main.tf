terraform {
  required_version = ">= 1.5.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.129"
    }
  }
}

provider "yandex" {
  zone = var.default_zone
}

data "yandex_client_config" "client" {}

locals {
  project_labels = {
    project     = var.project_name
    environment = var.environment
  }
}
