terraform {
 backend "gcs" {
   # Name of the GCS  bucket for storing tfstate file
   bucket  = "gke-dr-clean-test"
   # Prefix for tfstate file
   prefix  = "terraform/dr-cluster/state"
 }
}
