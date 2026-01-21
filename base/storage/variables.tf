variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "bucket_name" {
  description = "Storage Bucket Name"
  type        = string
}

variable "storage_class" {
  description = "Storage Class"
  type        = string
  default     = "STANDARD"
}