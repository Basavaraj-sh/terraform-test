################# DR Network ##################

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

