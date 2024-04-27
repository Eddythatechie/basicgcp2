resource "google_compute_network" "auto-vpc" {
    name = "auto-vpc"
    auto_create_subnetworks = true
}

resource "google_compute_network" "custom-vpc" {
    name = "custom-vpc"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sa-east1" {
    name = "sa-east1"
    network = google_compute_network.custom-vpc.id
    ip_cidr_range = "10.0.1.0/24"
    region = "southamerica-east1"
    private_ip_google_access = true
  
}

resource "google_compute_subnetwork" "eu-west1" {
    name = "eu-west1"
    network = google_compute_network.auto-vpc.id
    ip_cidr_range = "10.0.2.0/24"
    region = "europe-west1"
    private_ip_google_access = true
  
}

output "auto-vpc" {
    value = google_compute_network.auto-vpc.id
  
}

output "custom-vpc" {
    value = google_compute_network.custom-vpc.id
  
}

resource "google_compute_firewall" "allow-icmp" {
    name = "icmp-test-firewall"
    network = google_compute_network.custom-vpc.id

    allow {
      protocol = "icmp"
    }
    source_ranges = ["99.170.44.121/32"]
    priority = 600
}