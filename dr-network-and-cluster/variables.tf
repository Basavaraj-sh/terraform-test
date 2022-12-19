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

####################################################################
variable "cluster_ipv4_cidr" {
  description = "IP address range for cluster PODs"
  default = ""
}

variable "master_authorized_networks_cidr_blocks" {
  type = list(map(string))
  description = "Authorized network for control plane access"
  default = []
}

variable "cluster_version" {
  description = "Minimum version of master"
  default = ""
}

variable "enable_backup_agent" {
  description = "Enable backup agent"
  default = false
}

variable "enable_master_global_access" {
  description = "Enaable master global access"
  default = true
}

variable "disk_size_gb" {
  type = number
  description = "Size of the disk attached to each node"
  default = 100 
}

variable "node_pool_service_account" {
  type = string
  description = "The Google Cloud Platform Service Account to be used by the node VMs"
  default = ""
}

variable "node_pool_oauth_scopes" {
  type = list(string)
  description = "Scopes that are used by nodes in the pools"
  default = ["https://www.googleapis.com/auth/logging.write",
             "https://www.googleapis.com/auth/monitoring.write",
             "https://www.googleapis.com/auth/monitoring",
             "https://www.googleapis.com/auth/bigquery",
             "https://www.googleapis.com/auth/pubsub",
             "https://www.googleapis.com/auth/compute",
             "https://www.googleapis.com/auth/servicecontrol",
             "https://www.googleapis.com/auth/service.management.readonly",
             "https://www.googleapis.com/auth/devstorage.full_control",
             ]
}

variable "autoscaling_min_node_count" {
  type = number
  description = "Minimum number of nodes per zone in node pool"
}

variable "autoscaling_max_node_count" {
  type = number
  description = "Maximum number of nodes per zone in node pool"
}

##########################################################
variable "cluster1_name" {
  description = "cluster name"
  default = ""
}

variable "cluster1_location" {
  description = "cluster location for cluster 1"
  default = ""
}

variable "cluster1_control_plane_ip_range" {
  description = "control plane ip range"
  default = ""
}

variable "cluster1_node_locations" {
  type = list(string)
  description = "Node locations for the cluster"
  default = []
}

variable "cluster1_node_labels" {
  type = map(string)
  description = "Node labels. Key value pair labels to be applyed to each node"
  default = {}
}

variable "cluster1_machine_type" {
  description = "Machine type for the GKE nodes"
  default = ""
}

variable "cluster1_node_count" {
  type = number
  description = "Node count for GKE cluster"
}


###########################################################
variable "cluster2_name" {
  description = "cluster name"
  default = ""
}

variable "cluster2_location" {
  description = "cluster location for cluster 2"
  default = ""
}

variable "cluster2_control_plane_ip_range" {
  description = "control plane ip range"
  default = ""
}

variable "cluster2_node_locations" {
  type = list(string)
  description = "Node locations for the cluster"
  default = []
}

variable "cluster2_node_labels" {
  type = map(string)
  description = "Node labels. Key value pair labels to be applyed to each node"
  default = {}
}

variable "cluster2_machine_type" {
  description = "Machine type for the GKE nodes"
  default = ""
}

variable "cluster2_node_count" {
  type = number
  description = "Node count for GKE cluster"
}

#######################################################
# Variables for application backup-restore plan. 
# Bacup-for-GKE feature is used for taking applications
# backups from GKE clusters
#######################################################
variable "create_backup_restore_plan" {
   description = "Create backup and restore plans"
}

variable "pri_to_sec_backup_plan_name" {
  description = "Application backup plan name for primary cluster to secondary cluster."
  default = ""
}

variable "sec_to_pri_backup_plan_name" {
  description = "Application backup plan name for secondary cluster to primary cluster."
  default = ""
}

variable "pri_to_sec_restore_plan_name" {
  description = "Application restore plan name for primary cluster to secondary cluster."
  default = ""
}

variable "sec_to_pri_restore_plan_name" {
  description = "Application restore plan name for secondary cluster to primary cluster."
  default = ""
}

variable "applications" {
  type = list
  description = "Liast of applications for which backups needs to be configured"
}

variable "backup_retain_days" {
  type = number
  description = "Number of days backups needs to be retained"
}

variable "backup_frequency_cron" {
  description = "Cron schedule for application backup"
}
