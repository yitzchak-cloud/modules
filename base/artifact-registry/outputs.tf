output "repository_name" {
  description = "Artifact Registry Repository Name"
  value       = google_artifact_registry_repository.this.name
}

output "repository_id" {
  description = "Artifact Registry Repository ID"
  value       = google_artifact_registry_repository.this.repository_id
}