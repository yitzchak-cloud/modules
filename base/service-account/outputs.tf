output "email" {
  description = "Service Account Email"
  value       = google_service_account.this.email
}

output "unique_id" {
  description = "Service Account Unique ID"
  value       = google_service_account.this.unique_id
}

output "name" {
  description = "Service Account Name"
  value       = google_service_account.this.name
}