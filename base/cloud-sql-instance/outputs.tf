output "connection_name" {
  description = "Cloud SQL Connection Name"
  value       = google_sql_database_instance.this.connection_name
}

output "instance_name" {
  description = "Cloud SQL Instance Name"
  value       = google_sql_database_instance.this.name
}

output "psc_dns_name" {
  description = "PSC DNS name for the Cloud SQL instance"
  value       = google_sql_database_instance.this.dns_name
}

output "database_name" {
  description = "Database Name"
  value       = google_sql_database.this.name
}

output "secret_id" {
  description = "Secret Manager Secret ID"
  value       = google_secret_manager_secret.db_password.secret_id
}

output "psc_service_attachment" {
  description = "PSC Service Attachment Link"
  value       = google_sql_database_instance.this.psc_service_attachment_link
}

output "private_ip_address" {
  value = google_sql_database_instance.this.ip_address[0].ip_address
}
