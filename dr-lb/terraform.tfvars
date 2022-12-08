# Service account for terraform script execution
# Provide service account email. Ex: "YOUR_SERVICE_ACCOUNT@YOUR_PROJECT.iam.gserviceaccount.com"
tf_service_account            = "tf-gke-dr-svc-account@k8s-exp-367504.iam.gserviceaccount.com"

# GCP Project ID
project_id                    = "k8s-exp-367504"

# Name prefix for the LB and backend resources
gke-dr-prefix                 = "thd-dr-test"

# IP of external Haproxy service deployed on primary cluster
nw_endpoint1_ip               = "35.233.93.31"

# IP of external Haproxy service deployed on secondary cluster
nw_endpoint2_ip               = "35.233.93.32"

# IP of internal Haproxy service deployed on primary cluster
nw_endpoint1_ip_internal      = "35.233.93.33"

# IP of internal Haproxy service deployed on secondary cluster
nw_endpoint2_ip_internal      = "35.233.93.34"

# Reserved static IP for external Global LoadBalancer
global_lb_ip                  = "34.160.242.13"

# Reserved static IP for internal Global LoadBalancer
global_lb_ip_internal         = "34.111.87.209"

# Name of the file containing SSL certificate names used with the LoadBalancers
# Every line in the file will have name of one certificate
# These SSL certificates must be pre-created in the cloud platform
certificate_list_file = "certificate_list"

# IAP oauth2 client ID for enabling IAP for internal LB
iap_oauth2_client_id_for_internal_lb        = "299409475323-pgcogciq8mehgbj6oj5ntp3lfhiep6rn.apps.googleusercontent.com"

# IAP oauth2 secret for enabling IAP for internal LB
# A secret must be pre-created in google secret manager and the name of the secret must be mentioned here
iap_oauth2_client_secret_name_internal_lb   = "iap_oauth2_client_secret_internal_lb"
