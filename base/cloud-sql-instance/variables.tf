variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "instance_name" {
  description = "Cloud SQL Instance Name"
  type        = string
}

variable "database_name" {
  description = "Database Name"
  type        = string
}

variable "db_user" {
  description = "Database User"
  type        = string
}

variable "secret_id" {
  description = "Secret Manager Secret ID for DB Password"
  type        = string
}

variable "network_host_project" {
  description = "Host Project for Shared VPC"
  type        = string
}

variable "network_name" {
  description = "VPC Network Name"
  type        = string
}

variable "service_account_email" {
  description = "Service Account Email for Secret Access"
  type        = string
}