variable "project_id" {
  description = "project id"
  default = ""
}

variable "cluster_name" {
  description = "cluster name"
  default = ""
}

variable "description" {
  description = "cluster description"
  default = ""
}

variable "location" {
  description = "cluster location"
  default = ""
}

variable "network" {
  description = "VPC network for cluster creation"
  default = ""
}

variable "subnetwork" {
  description = "Subnetwork for cluster creation"
  default = ""
}

variable "cluster_ipv4_cidr" {
  description = "IP address range for cluster PODs"
  default = ""
}

variable "logging_service" {
  description = "Logging service for cluster"
  default = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  description = "Monitoring service for cluster"
  default = "monitoring.googleapis.com/kubernetes"
}

variable "control_plane_ip_range" {
  description = "control plane ip range"
  default = ""
}

variable "master_authorized_ip_range" {
  description = "Authorized network for control plane access"
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

variable "disable_hpa" {
  description = "Disable horizontal pod auto scaling"
  default = false
}

variable "disable_http_load_balancing" {
  description = "Disable http load balancing"
  default = false
}

variable "bin_auth_evaluation_mode" {
  description = "Binary authorization evaluation mode (Valid values are DISABLED and PROJECT_SINGLETON_POLICY_ENFORCE)"
  default = "DISABLED"
}

variable "enable_shielded_nodes" {
  description = "nable Shielded Nodes features on all nodes in this cluster"
  default = true
}

variable "node_locations" {
  type = list(string)
  description = "Node locations for the cluster"
  default = []
}

variable "node_labels" {
  type = map(string)
  description = "Node labels. Key value pair labels to be applyed to each node"
  default = {}
}

variable "machine_type" {
  description = "Machine type for the GKE nodes"
  default = ""
}

variable "disk_size_gb" {
  type = number
  description = "Size of the disk attached to each node"
  default = 100
}

variable "max_pods_per_node" {
  type = number
  description = "Maximum number pods per node"
  default = 110
}

variable "node_count" {
  type = number
  description = "Node count for GKE cluster"
}

variable "node_auto_repair" {
  type = string
  description = "Auto repair the nodes in node pool"
  default = true
}

variable "node_auto_upgrade" {
  type = string
  description = "Auto upgrade the nodes in node pool"
  default = false
}

variable "node_pool_disk_type" {
  type = string
  description = "Type of disk attached to each node in the node pool"
  default = "pd-standard"
}

variable "node_pool_service_account" {
  type = string
  description = "The Google Cloud Platform Service Account to be used by the node VMsa"
  default = ""
}

variable "node_pool_oauth_scopes" {
  type = list(string)
  description = "Scopes that are used by Noad Auto Provisioning when creating node pools"
  default = []
}

variable "gce_metadata" {
  type = map(string)
  description = "Node labels. Key value pair labels to be applyed to each node"
  default = {}
}

variable "disable_legacy_metadata_endpoints" {
  type = string
  description = "Key/value pair disable-legacy-endpoints on cluster instance"
  default = true
}

variable "enable_master_global_access" {
  description = "Enaable master global access"
}
