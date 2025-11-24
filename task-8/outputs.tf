output "vm_external_ip" {
  description = "External IP address of the application VM."
  value       = yandex_compute_instance.app.network_interface[0].nat_ip_address
}

output "db_fqdn" {
  description = "FQDN of the PostgreSQL cluster."
  value       = yandex_mdb_postgresql_cluster.db.host[0].fqdn
}

output "bucket_name" {
  description = "Name of the Object Storage bucket."
  value       = yandex_storage_bucket.app.bucket
}

output "service_account_id" {
  description = "ID of the service account used for bucket access."
  value       = yandex_iam_service_account.bucket_sa.id
}

output "bucket_access_key_id" {
  description = "Static access key ID for the bucket."
  value       = yandex_iam_service_account_static_access_key.bucket_sa_key.access_key
}

output "bucket_secret_key" {
  description = "Static secret key for the bucket."
  value       = yandex_iam_service_account_static_access_key.bucket_sa_key.secret_key
  sensitive   = true
}

output "db_connection_string" {
  description = "PostgreSQL connection string for the application."
  value       = "postgresql://${var.db_user}:${var.db_password}@${yandex_mdb_postgresql_cluster.db.host[0].fqdn}:5432/${var.db_name}"
  sensitive   = true
}
