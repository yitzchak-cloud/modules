variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "account_id" {
  description = "Service Account ID"
  type        = string
}

variable "display_name" {
  description = "Service Account Display Name"
  type        = string
}

variable "description" {
  description = "Service Account Description"
  type        = string
}

variable "roles" {
  description = "List of roles to assign to the service account"
  type        = list(string)
  default     = []
}

variable "project_roles" {
  description = "List of IAM roles to assign at project level (for multi target)"
  type        = list(string)
  default     = []
}

variable "cloud_run_roles" {
  description = "List of IAM roles to assign at Cloud Run level (for multi target)"
  type        = list(string)
  default     = []
}

variable "bucket_roles" {
  description = "List of IAM roles to assign at Bucket level (for multi target)"
  type        = list(string)
  default     = []
}

variable "target_type" {
  description = "Type of target for IAM roles: 'project', 'bucket', or 'cloud_run' or 'multi'"
  type        = string
  default     = "project"
  
  validation {
    condition     = contains(["project", "bucket", "cloud_run", "multi"], var.target_type)
    error_message = "target_type must be either 'project', 'bucket', 'cloud_run', or 'multi'."
  }
}

variable "target_bucket_name" {
  description = "Bucket name when target_type is 'bucket'"
  type        = string
  default     = null
}

variable "target_cloud_run_service" {
  description = "Cloud Run service name when target_type is 'cloud_run'"
  type        = string
  default     = null
}

variable "target_cloud_run_location" {
  description = "Cloud Run service location when target_type is 'cloud_run'"
  type        = string
  default     = null
}
