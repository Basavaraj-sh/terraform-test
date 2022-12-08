variable "project_id" {
  description = "project id"
  default = ""
}

variable "auto_create_subnetworks" {
  description = "Auto create subnets for the vpc"
  default = false
}

################### Network and Subnets ##################
variable "network_name" {
  description = "Name of the network to be created"
}

variable "subnet1_name" {
  description = "Name of the subnetwork to be created in region 1"
}

variable "subnet2_name" {
  description = "Name of the subnetwork to be created in region 2"
}

variable routing_mode {
  description = "Network-wide routing mode"
  default     = "REGIONAL"
}

variable network_mtu {
  type        = number
  description = "Maximum Transmission Unit in bytes"
  default     = 1460
}

variable "region_1" {
  description = "region"
  default = ""
}

variable "region_2" {
  description = "region"
  default = ""
}

variable "subnet1_cidr" {
  description = "cidr value for subnet1"
  default = ""
}

variable "subnet2_cidr" {
  description = "cidr value for subnet2"
  default = ""
}

variable "private_ip_google_access" {
  description = "When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access."
}

variable "nat_ip_allocation_option" {
  description = "How external IPs should be allocated for this NAT"
  default     = "AUTO_ONLY"
}

variable "source_subnetwork_ip_range_to_nat" {
  description = "How NAT should be configured per Subnetwork"
  default = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "network-prefix" {
  description = "prefix to identify network resourcess"
  default = "thd"
}

