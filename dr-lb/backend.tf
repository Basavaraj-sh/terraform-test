terraform {
 backend "gcs" {
   bucket                      = "gke-dr-clean-test"
   prefix                      = "terraform/dr-lb/state"
 }
}
