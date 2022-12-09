terraform {
 backend "gcs" {
   bucket                      = ""
   prefix                      = "terraform/dr-lb/state"
 }
}
