output "region_1" {
  value       = var.region_1
  description = "GCloud Region"
}

output "region_2" {
  value       = var.region_2
  description = "GCloud Region"
}


output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "network_id" {
  value = google_compute_network.vpc.id
  description = "network id"
}


output "subnet_1_id" {
  value = google_compute_subnetwork.subnet_1.id
  description = "subnet id for subnet_1"
}


output "subnet_2_id" {
  value = google_compute_subnetwork.subnet_2.id
  description = "subnet id for subnet_2"
}


output "router1" {
  value = google_compute_router.router1.id
  description = "router id for router 1"
}

output "router2" {
  value = google_compute_router.router2.id
  description = "router id for router 2"
}

output "nat1" {
  value = google_compute_router_nat.nat1.id
  description = "nat id for nat 1"
}

output "nat2" {
  value = google_compute_router_nat.nat2.id
  description = "nat id for nat 2"
}

