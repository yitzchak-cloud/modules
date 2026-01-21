
# Enable required APIs
resource "google_project_service" "required_apis" {
  for_each = toset([
    "secretmanager.googleapis.com",
    "sqladmin.googleapis.com",
  ])

  service            = each.value
  project = var.project_id
  disable_on_destroy = false
}

data "google_compute_network" "shared_vpc" {
  name    = var.network_name
  project = var.network_host_project
}

resource "google_sql_database_instance" "this" {
  project             = var.project_id
  name                = var.instance_name
  database_version    = "POSTGRES_16"
  region              = var.region
  deletion_protection = false

  settings {
    tier              = "db-perf-optimized-N-8"
    availability_type = "ZONAL"
    disk_type         = "PD_SSD"
    disk_size         = 100

    ip_configuration {
      ipv4_enabled                                  = false
      private_network = data.google_compute_network.shared_vpc.self_link
      # psc_config {
      #     psc_enabled = true
      #     allowed_consumer_projects = [var.project_id]
      # }
      enable_private_path_for_google_cloud_services = true
    }
  }
  depends_on = [
    google_project_service.required_apis,
  ]
}

resource "google_sql_database" "this" {
  name     = var.database_name
  instance = google_sql_database_instance.this.name
  project  = var.project_id
}

resource "random_password" "db_password" {
  length  = 32
  special = true
}

resource "google_secret_manager_secret" "db_password" {
  project   = var.project_id
  secret_id = var.secret_id

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "db_password_version" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = random_password.db_password.result
}

resource "google_sql_user" "this" {
  project  = var.project_id
  name     = var.db_user
  instance = google_sql_database_instance.this.name
  password = random_password.db_password.result
}

resource "google_secret_manager_secret_iam_member" "secret_access" {
  project   = var.project_id
  secret_id = google_secret_manager_secret.db_password.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.service_account_email}"
}