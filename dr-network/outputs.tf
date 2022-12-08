output "region_1" {
  value       = module.gke-dr-nw.region_1
  description = "GCloud Region"
}

output "region_2" {
  value       = module.gke-dr-nw.region_2
  description = "GCloud Region"
}


output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "network_id" {
  value       = module.gke-dr-nw.network_id
  description = "network id"
}


output "subnet_1_id" {
  value       = module.gke-dr-nw.subnet_1_id
  description = "subnet id for subnet_1"
}


output "subnet_2_id" {
  value       = module.gke-dr-nw.subnet_2_id
  description = "subnet id for subnet_2"
}

output "router1" {
  value       = module.gke-dr-nw.router1
  description = "Router id for router1"
}

output "router2" {
  value       = module.gke-dr-nw.router2
  description = "Router id for router2"
}

output "nat1" {
  value       = module.gke-dr-nw.nat1
  description = "NAT id for nat 1"
}

output "nat2" {
  value       = module.gke-dr-nw.nat2
  description = "NAT id for nat 2"
}

