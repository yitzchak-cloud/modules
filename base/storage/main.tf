resource "google_storage_bucket" "this" {
  project       = var.project_id
  name          = var.bucket_name
  location      = var.region
  storage_class = var.storage_class

  force_destroy = true
  uniform_bucket_level_access = true
}