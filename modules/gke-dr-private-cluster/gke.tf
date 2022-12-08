# GKE cluster
# google-beta terraform module is used, as gke-backup feature is not generally available
# Once this feature is available in genral module, the line below with "provider = google-beta"
# can be removed
resource "google_container_cluster" "cluster" {
  provider = google-beta
  name                    = var.cluster_name
  description             = var.description
  location                = var.location
  project                 = var.project_id
  node_locations          = var.node_locations
  network                 = var.network
  subnetwork              = var.subnetwork
  min_master_version      = var.cluster_version
  
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  addons_config {
    gke_backup_agent_config {
      enabled = var.enable_backup_agent
    }
		
    horizontal_pod_autoscaling {
      disabled = var.disable_hpa
    }
	
    http_load_balancing {
      disabled = var.disable_http_load_balancing 
    }
  }

  binary_authorization {
    evaluation_mode = var.bin_auth_evaluation_mode 
  }

  enable_shielded_nodes = var.enable_shielded_nodes
 
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    managed_prometheus {
      enabled = true
    }
  }


# Remove the default node pool which gets created with the cluster
# Initial node count of default node pool cannot be zero
# A separate node pool will be created with google_container_node_pool resource

  remove_default_node_pool = true
  initial_node_count       = 1 

  ip_allocation_policy {
  }

# Private cluister config
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.control_plane_ip_range
    master_global_access_config {
      enabled = false 
   }
  }

  datapath_provider = "ADVANCED_DATAPATH"

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_networks_cidr_blocks
      content {
        cidr_block   = cidr_blocks.value.cidr_block
        display_name = cidr_blocks.value.display_name
      }
   }
 }
}


# Separately Managed Node Pool
resource "google_container_node_pool" "node-pool" {
  name              = "${var.cluster_name}-pool"
  project           = var.project_id
  location          = var.location
  cluster           = google_container_cluster.cluster.name
  node_count        = var.node_count
  node_locations    = var.node_locations
  version           = google_container_cluster.cluster.min_master_version 
  max_pods_per_node = var.max_pods_per_node
  node_config {
    labels       =  var.node_labels
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = var.node_pool_disk_type
 
   service_account = var.node_pool_service_account
   oauth_scopes = var.node_pool_oauth_scopes

    metadata = merge(
        {
        "disable-legacy-endpoints" = var.disable_legacy_metadata_endpoints
        },
        var.gce_metadata
    )
  }

  autoscaling {
    min_node_count = var.autoscaling_min_node_count
    max_node_count = var.autoscaling_max_node_count
  }

  management {
    auto_repair  = var.node_auto_repair 
    auto_upgrade = var.node_auto_upgrade
  }
}

