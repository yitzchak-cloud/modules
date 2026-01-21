variable "project_id" {
  description = "GCP Project ID"
  type        = string
}
 
variable "name" {
  description = "VM instance name"
  type        = string
}
 
variable "region" {
  type        = string
  description = "GCP region"
}
 
variable "zone" {
  description = "GCP zone for the VM"
  type        = string
}
 
variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
  default     = "e2-medium"
}
 
variable "network_host_project" {
  type        = string
  description = "Network host project ID"
}
 
variable "network_name" {
  description = "Network name"
  type        = string
  default     = "default"
}
 
variable "subnet_name" {
  description = "Subnetwork name (optional)"
  type        = string
  default     = null
}
 
variable "tags" {
  description = "Network tags"
  type        = list(string)
  default     = []
}
 
variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = number
  default     = 10
}
 
variable "disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "pd-standard"
}
 
variable "image_family" {
  description = "Image family for the VM"
  type        = string
  default     = "ubuntu-2204-lts"
}
 
variable "image_project" {
  description = "Project where the image is located"
  type        = string
  default     = "ubuntu-os-cloud"
}
 