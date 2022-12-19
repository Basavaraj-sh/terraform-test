locals {
   applications_string = join(",", var.applications)
}
###################################################################

module "gke-dr-nw" {
  source           = "../modules/gke-dr-network/"
  project_id       = var.project_id
  network_name     = var.network_name
  subnet1_name     = var.subnet1_name
  region_1         = var.region_1
  subnet1_cidr     = var.subnet1_cidr
  subnet2_name     = var.subnet2_name
  region_2         = var.region_2
  subnet2_cidr     = var.subnet2_cidr
  private_ip_google_access = var.private_ip_google_access
  network-prefix           = var.network-prefix
}

module "gke-dr-pri-cluster-1" {
  source                  = "../modules/gke-dr-private-cluster/"
  cluster_name            = var.cluster1_name
  location                = var.cluster1_location
  project_id              = var.project_id
  node_locations          = var.cluster1_node_locations
  node_count              = var.cluster1_node_count
  node_labels             = var.cluster1_node_labels
  disk_size_gb            = var.disk_size_gb
  network                 = module.gke-dr-nw.network_id
  subnetwork              = module.gke-dr-nw.subnet_1_id
  cluster_version         = var.cluster_version
  machine_type            = var.cluster1_machine_type
  autoscaling_min_node_count  = var.autoscaling_min_node_count
  autoscaling_max_node_count  = var.autoscaling_max_node_count  

  control_plane_ip_range      = var.cluster1_control_plane_ip_range
  enable_master_global_access = var.enable_master_global_access
  enable_backup_agent         = var.enable_backup_agent
  node_pool_oauth_scopes      = var.node_pool_oauth_scopes
  master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
}

module "gke-dr-pri-cluster-2" {
  source                  = "../modules/gke-dr-private-cluster/"
  cluster_name            = var.cluster2_name
  location                = var.cluster2_location
  project_id              = var.project_id
  node_locations          = var.cluster2_node_locations
  node_count              = var.cluster2_node_count
  node_labels             = var.cluster2_node_labels
  disk_size_gb            = var.disk_size_gb
  network                 = module.gke-dr-nw.network_id
  subnetwork              = module.gke-dr-nw.subnet_2_id
  cluster_version         = var.cluster_version
  machine_type            = var.cluster2_machine_type
  autoscaling_min_node_count  = var.autoscaling_min_node_count
  autoscaling_max_node_count  = var.autoscaling_max_node_count

  control_plane_ip_range      = var.cluster2_control_plane_ip_range
  enable_master_global_access = var.enable_master_global_access
  enable_backup_agent         = var.enable_backup_agent
  node_pool_oauth_scopes      = var.node_pool_oauth_scopes
  master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
}

################## Create backup and restore plan for elasticsearch and rabbitmq ##########
resource "null_resource" "create-pri-to-sec-backup-plan" {
 count = var.create_backup_restore_plan ? 1 : 0
 provisioner "local-exec" {

   command = "gcloud beta container backup-restore backup-plans create ${var.pri_to_sec_backup_plan_name} --project=${var.project_id} --location=${var.cluster2_location} --cluster=projects/${var.project_id}/locations/${var.cluster1_location}/clusters/${var.cluster1_name} --selected-applications=${local.applications_string} --include-secrets --include-volume-data --backup-retain-days=${var.backup_retain_days} --cron-schedule=\"${var.backup_frequency_cron}\""
  }

  depends_on = [module.gke-dr-pri-cluster-1]
}

resource "null_resource" "create-pri-to-sec-restore-plan" {
 count = var.create_backup_restore_plan ? 1 : 0
 provisioner "local-exec" {

    command = "gcloud beta container backup-restore restore-plans create ${var.pri_to_sec_restore_plan_name} --project=${var.project_id} --location=${var.cluster2_location} --backup-plan=projects/${var.project_id}/locations/${var.cluster2_location}/backupPlans/${var.pri_to_sec_backup_plan_name} --cluster=projects/${var.project_id}/locations/${var.cluster2_location}/clusters/${var.cluster2_name} --volume-data-restore-policy=restore-volume-data-from-backup --namespaced-resource-restore-mode=delete-and-restore --cluster-resource-conflict-policy=use-backup-version --cluster-resource-restore-scope= --all-namespaces"
  }

  depends_on = [null_resource.create-pri-to-sec-backup-plan, module.gke-dr-pri-cluster-2]
}

resource "null_resource" "create-sec-to-pri-backup-plan" {
 count = var.create_backup_restore_plan ? 1 : 0
 provisioner "local-exec" {

    command = "gcloud beta container backup-restore backup-plans create ${var.sec_to_pri_backup_plan_name} --project=${var.project_id} --location=${var.cluster1_location} --cluster=projects/${var.project_id}/locations/${var.cluster2_location}/clusters/${var.cluster2_name} --selected-applications=${local.applications_string} --include-secrets --include-volume-data --backup-retain-days=${var.backup_retain_days} --cron-schedule=\"${var.backup_frequency_cron}\""
  }

  depends_on = [module.gke-dr-pri-cluster-2]
}

resource "null_resource" "create-sec-to-pri-restore-plan" {
 count = var.create_backup_restore_plan ? 1 : 0
 provisioner "local-exec" {

    command = "gcloud beta container backup-restore restore-plans create ${var.sec_to_pri_restore_plan_name} --project=${var.project_id} --location=${var.cluster1_location} --backup-plan=projects/${var.project_id}/locations/${var.cluster1_location}/backupPlans/${var.sec_to_pri_backup_plan_name} --cluster=projects/${var.project_id}/locations/${var.cluster1_location}/clusters/${var.cluster1_name} --volume-data-restore-policy=restore-volume-data-from-backup --namespaced-resource-restore-mode=delete-and-restore --cluster-resource-conflict-policy=use-backup-version --cluster-resource-restore-scope= --all-namespaces"
  }
  depends_on = [null_resource.create-sec-to-pri-backup-plan,module.gke-dr-pri-cluster-1]
}
