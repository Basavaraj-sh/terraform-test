##### Service account for terraform script execution ######
## Provide service account email. Ex "YOUR_SERVICE_ACCOUNT@YOUR_PROJECT.iam.gserviceaccount.com"

#tf_service_account = "tf-gke-dr-svc-account@k8s-exp-367504.iam.gserviceaccount.com"

############## Variables for network creation #############
project_id     = "k8s-exp-367504"

network_name   = "thd-dr-test-network"

subnet1_name   = "thd-dr-test-subnet1"

subnet2_name   = "thd-dr-test-subnet2"

region_1       = "asia-south1"

region_2       = "asia-south2"

enable_master_global_access = false

# Enable/Disable gke backup agent
enable_backup_agent = true

############# Variables for Primaryg Cluster################
cluster1_name                   = "thd-dr-test-primary"
cluster1_location               = "asia-south1"
cluster1_node_locations         = ["asia-south1-a"]
cluster1_control_plane_ip_range = "172.16.0.0/28"
cluster1_node_count             = 1
cluster1_machine_type           = "e2-standard-4"
cluster1_node_labels            = {
  environment = "THD-development-1"
}

############# Variables for Secendary Cluster################
cluster2_name                   = "thd-dr-test-secondary"
cluster2_location               = "asia-south2"
cluster2_node_locations         = ["asia-south2-a"]
cluster2_control_plane_ip_range = "172.17.0.0/28"
cluster2_node_count             = 1
cluster2_machine_type           = "e2-standard-4"
cluster2_node_labels            = {
  environment = "THD-development-1"
}

############ Common variables for cluster setup #############

#Auto scaling Minimum and Maximum number of nodes per zone in node pool
autoscaling_min_node_count = 1
autoscaling_max_node_count = 2

cluster_version    = "1.21.14-gke.7100"

disk_size_gb       = 50

# Add network cidr blocks to allow access to gke clusters
# Example:
# master_authorized_networks_cidr_blocks = [
#  {
#    cidr_block   = "<IP>/32"
#    display_name = "Jenkins Server"
#  },
#  ]
#
master_authorized_networks_cidr_blocks = [
  {
    cidr_block   = "124.123.80.114/32"
    display_name = "Jenkins-NP"
  }
]

############ Variables for application backup and restore plans ########
# For creating gke application backup/restore plans
# "enable_backup_agent" flag (provided in the cluster section) )must also
# be set to true while creating the cluster
#
create_backup_restore_plan = true

# Names Must use lowercase letters, numbers, and hyphens and start with letter
pri_to_sec_backup_plan_name = "pts-bkp"
sec_to_pri_backup_plan_name = "stp-bkp"

pri_to_sec_restore_plan_name = "pts-rest"
sec_to_pri_restore_plan_name = "stp-rest"

# List protected application names for which backup/restore plan
# has to be created
# Example: applications = ["<namespace>/<application>-backup"]
applications = ["dr-primary/elasticsearch-backup","dr-primary/rabbit-mq-backup"]

backup_retain_days = 1
