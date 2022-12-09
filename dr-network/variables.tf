variable "project_id" {
  description = "project id"
  default = ""
}

###### Primary and secondary regions for DR network ######
variable "region_1" {
  description = "region"
  default = ""
}

variable "region_2" {
  description = "region"
  default = ""
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
  default = true
}

variable "network-prefix" {
  description = "Name prefix for network resources"
  default = "thd"
}
