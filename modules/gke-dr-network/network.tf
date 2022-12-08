
########################## VPC ##############################
resource "google_compute_network" "vpc" {
  name                    = var.network_name 
  project                 = var.project_id
  auto_create_subnetworks = var.auto_create_subnetworks 
  routing_mode            = var.routing_mode
  mtu                     = var.network_mtu
}

######################### Subnet ############################
resource "google_compute_subnetwork" "subnet_1" {
  name          = var.subnet1_name 
  project       = var.project_id
  region        = var.region_1
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.subnet1_cidr
  private_ip_google_access = var.private_ip_google_access
}

resource "google_compute_subnetwork" "subnet_2" {
  name          = var.subnet2_name 
  project       = var.project_id
  region        = var.region_2
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.subnet2_cidr
  private_ip_google_access = var.private_ip_google_access
}

####################### Cloud Router ########################

resource "google_compute_router" "router1" {
  name          = "${var.network-prefix}-route1" 
  network       = google_compute_network.vpc.name
  region        = var.region_1
  project = var.project_id
}


resource "google_compute_router" "router2" {
  name          = "${var.network-prefix}-route2" 
  network       = google_compute_network.vpc.name
  region        = var.region_2
  project       = var.project_id
}

##################### NAT Gateway ###########################
resource "google_compute_router_nat" "nat1" {
  name                               = "${var.network-prefix}-nat1" 
  router                             = google_compute_router.router1.name
  region                             = google_compute_router.router1.region
  nat_ip_allocate_option             = var.nat_ip_allocation_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_range_to_nat
  project                            = var.project_id

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_router_nat" "nat2" {
  name                               = "${var.network-prefix}-nat2" 
  router                             = google_compute_router.router2.name
  region                             = google_compute_router.router2.region
  nat_ip_allocate_option             = var.nat_ip_allocation_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_range_to_nat
  project                            = var.project_id

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
