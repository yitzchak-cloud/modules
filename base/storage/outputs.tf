output "bucket_name" {
  description = "Storage Bucket Name"
  value       = google_storage_bucket.this.name
}

output "bucket_url" {
  description = "Storage Bucket URL"
  value       = google_storage_bucket.this.url
}