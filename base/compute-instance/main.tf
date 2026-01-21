# Get the shared VPC
data "google_compute_network" "shared_vpc" {
    name    = var.network_name
    project = var.network_host_project
}

# Get the shared subnet
data "google_compute_subnetwork" "shared_subnet" {
    name    = var.subnet_name
    project = var.network_host_project
    region  = var.region
}

# Create the VM
resource "google_compute_instance" "vm_instance" {
  name         = var.name
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type
 
  shielded_instance_config {
    enable_secure_boot = true  # מאפשר Secure Boot
    enable_vtpm        = true  # מאפשר vTPM
    enable_integrity_monitoring = true  # מאפשר Integrity Monitoring
  }
 
  boot_disk {
    initialize_params {
      image = data.google_compute_image.vm_image.self_link
      size  = var.disk_size_gb
      type  = var.disk_type
    }
  }
 
  network_interface {
    network    = data.google_compute_network.shared_vpc.id
    subnetwork = data.google_compute_subnetwork.shared_subnet.id
 
  }
 
  tags = var.tags
}
 
data "google_compute_image" "vm_image" {
  family  = var.image_family
  project = var.image_project
}