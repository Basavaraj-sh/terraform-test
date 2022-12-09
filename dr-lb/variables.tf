variable "gke-dr-prefix" {
  description = "prefix to identify GKE DR setup resourcess"
  default = "thd-gkedr"
}

variable "project_id" {
  description = "project id"
}

variable "neg_type" {
  description = "Global network endpoint group type"
  default = "INTERNET_IP_PORT"
}

variable "neg_port" {
  description = "Global network-endpoint-group port"
  default = 443
}

variable "nw_endpoint_port" {
  description = "Network endpoint port"
  default = 443
}

variable "nw_endpoint1_ip" {
  description = "Global network-endpoint ip address"
}

variable "nw_endpoint2_ip" {
  description = "Global network-endpoint ip address"
}

variable "nw_endpoint1_ip_internal" {
  description = "Global network-endpoint ip address for internal haproxy"
}

variable "nw_endpoint2_ip_internal" {
  description = "Global network-endpoint ip address for internal haproxy"
}

variable "backend_svc_protocol" {
  description = "The protocol this BackendService uses to communicate with backends"
  default = "HTTPS"
}

variable "backend_svc_cdn_enable" {
  description = "Enable CDN for backend service"
  default = false
}

variable "backend_svc_timeout" {
  description = "Timeout value for backend service"
  default = 60
}

variable "backend_svc_connection_drain_timeout" {
  description = "Timeout value for backend service connection drainout"
  default = 60
}

variable "global_lb_ip" {
  description = "Global ip address for loadbalancer"
  default = ""
}

variable "global_lb_ip_internal" {
  description = "Global ip address for loadbalancer, internal haproxy backend"
  default = ""
}

variable "lb_protocol" {
  description = "Global loadbalancer protocol"
  default = "TCP"
}

variable "lb_scheme" {
  description = "Global loadbalancer scheme"
  default = "EXTERNAL"
}

variable "lb_port_range" {
  description = "Global loadbalancer port range"
  default = "443"
}

variable "certificate_list_file" {
  description = "File containing list of SSL certificates used with Global Load Balancers"
}

variable "iap_oauth2_client_id_for_internal_lb" {
  description = "oauth2 client id for enabling IAP for internal load balancer"
}

variable "iap_oauth2_client_secret_name_internal_lb" {
  description = "name of the oauth2 client secr for enabling IAP for internal load balancer. The secret must be precreated in google secret manager"
}
