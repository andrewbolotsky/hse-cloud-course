
resource "yandex_iam_service_account" "bucket_sa" {
  name        = "${var.project_name}-bucket-sa"
  description = "Service account for Object Storage access"
}

resource "yandex_resourcemanager_folder_iam_member" "bucket_sa_storage_admin" {
  folder_id = data.yandex_client_config.client.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.bucket_sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "bucket_sa_key" {
  service_account_id = yandex_iam_service_account.bucket_sa.id
  description        = "Static access key for Object Storage bucket"
}

resource "yandex_storage_bucket" "app" {
  bucket = var.bucket_name

  access_key = yandex_iam_service_account_static_access_key.bucket_sa_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.bucket_sa_key.secret_key

  force_destroy = true

  anonymous_access_flags {
    read = false
    list = false
  }

  depends_on = [yandex_resourcemanager_folder_iam_member.bucket_sa_storage_admin]
}
