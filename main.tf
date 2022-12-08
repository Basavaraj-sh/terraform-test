resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
 }

resource "null_resource" "list-cluster" {

  provisioner "local-exec" {
    command = "gcloud compute networks list --project=${var.project_id}"
  }
}
