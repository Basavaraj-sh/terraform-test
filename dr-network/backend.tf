terraform {
 backend "gcs" {
   # Name of the GCS  bucket for storing tfstate file
   bucket  = ""
   # Prefix for tfstate file
   prefix  = "terraform/dr-network/state"
 }
}
