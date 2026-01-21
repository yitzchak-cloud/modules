
data "google_compute_network" "shared_vpc" {
  name    = var.network_name
  project = var.network_host_project
}

data "google_compute_subnetwork" "shared_subnet" {
  name    = var.subnet_name
  project = var.network_host_project
  region  = var.region
}

resource "google_cloud_run_v2_service" "this" {
  provider = google-beta
  project  = var.project_id
  name     = var.service_name
  location = var.region

  ingress             = var.ingress
  deletion_protection = var.deletion_protection
  launch_stage        = var.launch_stage
  iap_enabled         = var.iap_enabled
  
  template {
    service_account = var.service_account_email

    # VPC Access - תמיד קיים
    vpc_access {
      egress = var.vpc_egress
      network_interfaces {
        network    = data.google_compute_network.shared_vpc.id
        subnetwork = data.google_compute_subnetwork.shared_subnet.id
      }
    }

    # Cloud SQL Proxy - אופציונלי (ברירת מחדל: לא)
    dynamic "volumes" {
      for_each = var.enable_cloudsql_proxy ? [1] : []
      content {
        name = "cloudsql"
        cloud_sql_instance {
          instances = var.cloudsql_instances
        }
      }
    }

    containers {
      image = var.image

      # Environment variables - דינמי
      dynamic "env" {
        for_each = var.environment_variables
        content {
          name  = env.value.name
          value = env.value.value
        }
      }

      # Secret environment variables - דינמי
      dynamic "env" {
        for_each = var.secret_environment_variables
        content {
          name = env.value.name
          value_source {
            secret_key_ref {
              secret  = env.value.secret
              version = env.value.version
            }
          }
        }
      }

      # Cloud SQL Volume Mount - אופציונלי
      dynamic "volume_mounts" {
        for_each = var.enable_cloudsql_proxy ? [1] : []
        content {
          name       = "cloudsql"
          mount_path = "/cloudsql"
        }
      }

      # Ports - אופציונלי (רק אם צוין)
      dynamic "ports" {
        for_each = var.container_port != null ? [1] : []
        content {
          container_port = var.container_port
        }
      }
    }
  }
}

data "google_project" "project" {
    project_id = var.project_id
}

resource "google_cloud_run_v2_service_iam_member" "iap_invoker" {
  count = var.iap_enabled ? 1 : 0

  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.this.name

  role   = "roles/run.invoker"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-iap.iam.gserviceaccount.com"
}