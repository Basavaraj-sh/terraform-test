############## Variables for network creation #############
project_id     = "k8s-exp-367504"

network_name   = "thd-network"

subnet1_name   = "thd-subnet1"
region_1       = "asia-south1"
subnet1_cidr   = "10.1.0.0/16"

subnet2_name   = "thd-subnet2"
region_2       = "asia-south2"
subnet2_cidr   = "10.2.0.0/16"

# Prefix used in the names of all the network resorces created for DR setup
network-prefix = "thd"

enable_master_global_access = false

# Enable/Disable gke backup agent
enable_backup_agent = true

############# Variables for Primaryg Cluster################
cluster1_name                   = "test-primary"
cluster1_location               = "asia-south1"
cluster1_node_locations         = ["asia-south1-a"]
cluster1_control_plane_ip_range = "172.16.0.0/28"
cluster1_node_count             = 1
cluster1_machine_type           = "e2-standard-4"
cluster1_node_labels            = {
  environment = "THD-development-1"
}

############# Variables for Secendary Cluster################
cluster2_name                   = "test-secondary"
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

backup_frequency_cron = "*/30 * * * *"
