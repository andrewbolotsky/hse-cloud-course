variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
  default     = "hse-cloud-app"
}

variable "environment" {
  description = "Environment name (dev, stage, prod)."
  type        = string
  default     = "dev"
}

variable "default_zone" {
  description = "Default availability zone."
  type        = string
  default     = "ru-central1-a"
}

variable "subnet_cidr" {
  description = "CIDR for the application subnet."
  type        = string
  default     = "10.10.0.0/24"
}

variable "instance_cores" {
  description = "Number of vCPU cores for the VM."
  type        = number
  default     = 2
}

variable "instance_memory" {
  description = "Amount of RAM for the VM in GB."
  type        = number
  default     = 2
}

variable "instance_core_fraction" {
  description = "Core fraction for the VM (burstable instances)."
  type        = number
  default     = 20
}

variable "instance_disk_size" {
  description = "Boot disk size for the VM in GB."
  type        = number
  default     = 20
}

variable "instance_ssh_user" {
  description = "Linux username for SSH access to the VM."
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key" {
  description = "SSH public key to access the VM (e.g. from ~/.ssh/id_ed25519.pub)."
  type        = string
}

variable "db_environment" {
  description = "Environment for Managed PostgreSQL (PRESTABLE or PRODUCTION)."
  type        = string
  default     = "PRODUCTION"
}

variable "db_version" {
  description = "PostgreSQL version for the managed cluster."
  type        = string
  default     = "14"
}

variable "db_resource_preset" {
  description = "Resource preset for the managed PostgreSQL cluster."
  type        = string
  default     = "b1.medium"
}

variable "db_disk_size" {
  description = "Disk size for the PostgreSQL cluster in GB."
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Application database name."
  type        = string
  default     = "app_db"
}

variable "db_user" {
  description = "Application database user name."
  type        = string
  default     = "app_user"
}

variable "db_password" {
  description = "Password for the application database user."
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "Globally unique name for the Object Storage bucket."
  type        = string
}
