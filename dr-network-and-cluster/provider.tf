provider "google" {
 project           = var.project_id
}


## google-beta provider is used for cluster creation, as features like gke-backup are only available in beta
provider "google-beta" {
 project           = var.project_id
}
