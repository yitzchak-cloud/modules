output "service_url" {
  description = "Cloud Run Service URL"
  value       = google_cloud_run_v2_service.this.uri
}

output "service_name" {
  description = "Cloud Run Service Name"
  value       = google_cloud_run_v2_service.this.name
}

output "service_id" {
  description = "Cloud Run Service ID"
  value       = google_cloud_run_v2_service.this.id
}
