# modules/cloud-run-base/variables.tf

variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "service_name" {
  type        = string
  description = "Cloud Run service name"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "image" {
  type        = string
  description = "Container image"
}

variable "service_account_email" {
  type        = string
  description = "Service account email for Cloud Run"
}

variable "ingress" {
  type        = string
  default     = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  description = "Ingress traffic setting"
}

variable "deletion_protection" {
  type        = bool
  default     = false
  description = "Enable deletion protection"
}

variable "launch_stage" {
  type        = string
  default     = "BETA"
  description = "Launch stage"
}

variable "iap_enabled" {
  type        = bool
  default     = false
  description = "Enable IAP"
}

# VPC Access - חובה תמיד
variable "vpc_egress" {
  type        = string
  default     = "PRIVATE_RANGES_ONLY"
  description = "VPC egress setting"
}

variable "network_host_project" {
  type        = string
  description = "Network host project ID"
}

variable "network_name" {
  type        = string
  description = "VPC network name"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

# Cloud SQL - ברירת מחדל: false
variable "enable_cloudsql_proxy" {
  type        = bool
  default     = false
  description = "Enable Cloud SQL proxy sidecar"
}

variable "cloudsql_instances" {
  type        = list(string)
  default     = []
  description = "List of Cloud SQL instance connection names"
}

# Container Port - ברירת מחדל: null (לא מוגדר)
variable "container_port" {
  type        = number
  default     = null
  description = "Container port. If null, no port will be configured (uses default)"
}

# Environment Variables
variable "environment_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  description = "List of environment variables"
}

variable "secret_environment_variables" {
  type = list(object({
    name    = string
    secret  = string
    version = string
  }))
  default     = []
  description = "List of secret environment variables"
}