

variable "project_id" {
    type = string
    description = "GCP Project ID"
}

variable "region" {
    type = string
    description = "GCP Region"
}

variable "bucket_name" {
    type = string
    description = "Name of the Cloud Storage bucket to monitor"
}

variable "cloud_run_service_name" {
    type = string
    description = "Name of the Cloud Run service to trigger"
}

variable "trigger_name" {
    type = string
    description = "Name of the Eventarc trigger"
}

variable "eventarc_service_account_email" {
    type = string
    description = "Service Account email to be used by Eventarc trigger"
}


