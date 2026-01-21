resource "google_service_account" "this" {
  account_id   = var.account_id
  display_name = var.display_name
  description  = var.description
  project      = var.project_id
}

resource "google_project_iam_member" "roles" {
  for_each = var.target_type == "project" ? toset(var.roles) : (
    var.target_type == "multi" ? toset(var.project_roles) : toset([])
  )

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.this.email}"
}

# הרשאות ברמת bucket
resource "google_storage_bucket_iam_member" "roles" {
  for_each = var.target_type == "bucket" ? toset(var.roles) : (
  var.target_type == "multi" ? toset(var.bucket_roles) : toset([])
  )

  bucket = var.target_bucket_name
  role   = each.value
  member = "serviceAccount:${google_service_account.this.email}"
}


resource "google_cloud_run_service_iam_member" "roles" {
  for_each = var.target_type == "cloud_run" ? toset(var.roles) : (
    var.target_type == "multi" ? toset(var.cloud_run_roles) : toset([])
  )

  service  = var.target_cloud_run_service
  location = var.target_cloud_run_location
  role     = each.value
  member   = "serviceAccount:${google_service_account.this.email}"
}