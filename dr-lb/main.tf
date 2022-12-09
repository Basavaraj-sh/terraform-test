data "google_compute_ssl_certificate" "https_proxy_cert" {
  for_each    = toset(split("\n", chomp(file(var.certificate_list_file))))
  project     = var.project_id
  name        = each.key 
}

data "google_secret_manager_secret_version" "iap_oauth2_client_secret" {
  project     = var.project_id
  secret      = var.iap_oauth2_client_secret_name_internal_lb
}

#################### Network Endpoint for external haproxy ingress ########################
resource "google_compute_global_network_endpoint" "neg-endpoint1" {
    project                       = var.project_id
    global_network_endpoint_group = google_compute_global_network_endpoint_group.neg1.name
    ip_address                    = var.nw_endpoint1_ip 
    port                          = var.nw_endpoint_port
}

resource "google_compute_global_network_endpoint" "neg-endpoint2" {
    project                       = var.project_id
    global_network_endpoint_group = google_compute_global_network_endpoint_group.neg2.name
    ip_address                    = var.nw_endpoint2_ip 
    port                          = var.nw_endpoint_port
}

#################### Network Endpoint for internal haproxy ingress ########################
resource "google_compute_global_network_endpoint" "neg-endpoint1-internal" {
    project                       = var.project_id
    global_network_endpoint_group = google_compute_global_network_endpoint_group.neg1-internal.name
    ip_address                    = var.nw_endpoint1_ip_internal 
    port                          = var.nw_endpoint_port
}

resource "google_compute_global_network_endpoint" "neg-endpoint2-internal" {
    project                       = var.project_id
    global_network_endpoint_group = google_compute_global_network_endpoint_group.neg2-internal.name
    ip_address                    = var.nw_endpoint2_ip_internal 
    port                          = var.nw_endpoint_port
}

############### Network Endpoint Groups for external haproxy ########################
resource "google_compute_global_network_endpoint_group" "neg1" {
    project               = var.project_id
    name                  = "${var.gke-dr-prefix}-neg1"
    network_endpoint_type = var.neg_type
    default_port          = var.neg_port
}

resource "google_compute_global_network_endpoint_group" "neg2" {
    project               = var.project_id
    name                  = "${var.gke-dr-prefix}-neg2"
    network_endpoint_type = var.neg_type
    default_port          = var.neg_port
}

############### Network Endpoint Groups for internal haproxy ingress ########################
resource "google_compute_global_network_endpoint_group" "neg1-internal" {
    project               = var.project_id
    name                  = "${var.gke-dr-prefix}-neg1-internal"
    network_endpoint_type = var.neg_type
    default_port          = var.neg_port
}

resource "google_compute_global_network_endpoint_group" "neg2-internal" {
    project               = var.project_id
    name                  = "${var.gke-dr-prefix}-neg2-internal"
    network_endpoint_type = var.neg_type
    default_port          = var.neg_port
}

#################### Backend Service  for external haproxy ############################
resource "google_compute_backend_service" "backend-svc1" {
    project                         = var.project_id
    name                            = "${var.gke-dr-prefix}-backend-svc1"
    protocol                        = var.backend_svc_protocol
    enable_cdn                      = var.backend_svc_cdn_enable
    connection_draining_timeout_sec = var.backend_svc_connection_drain_timeout
    timeout_sec                     = var.backend_svc_timeout
    backend {
        group = google_compute_global_network_endpoint_group.neg1.id
    }
}

resource "google_compute_backend_service" "backend-svc2" {
    project                         = var.project_id
    name                            = "${var.gke-dr-prefix}-backend-svc2"
    protocol                        = var.backend_svc_protocol
    enable_cdn                      = var.backend_svc_cdn_enable
    connection_draining_timeout_sec = var.backend_svc_connection_drain_timeout
    timeout_sec                     = var.backend_svc_timeout
    backend {
        group = google_compute_global_network_endpoint_group.neg2.id
    }
}

#################### Backend Service for internal haproxy ingress############################
resource "google_compute_backend_service" "backend-svc1-internal" {
    project                         = var.project_id
    name                            = "${var.gke-dr-prefix}-backend-svc1-internal"
    protocol                        = var.backend_svc_protocol
    enable_cdn                      = var.backend_svc_cdn_enable
    connection_draining_timeout_sec = var.backend_svc_connection_drain_timeout
    timeout_sec                     = var.backend_svc_timeout
    backend {
        group = google_compute_global_network_endpoint_group.neg1-internal.id
    }
    iap {
        oauth2_client_id     = var.iap_oauth2_client_id_for_internal_lb
        oauth2_client_secret = data.google_secret_manager_secret_version.iap_oauth2_client_secret.secret_data
   }
}

resource "google_compute_backend_service" "backend-svc2-internal" {
    project                         = var.project_id
    name                            = "${var.gke-dr-prefix}-backend-svc2-internal"
    protocol                        = var.backend_svc_protocol
    enable_cdn                      = var.backend_svc_cdn_enable
    connection_draining_timeout_sec = var.backend_svc_connection_drain_timeout
    timeout_sec                     = var.backend_svc_timeout
    backend {
        group = google_compute_global_network_endpoint_group.neg2-internal.id
    }
    iap {
        oauth2_client_id     = var.iap_oauth2_client_id_for_internal_lb
        oauth2_client_secret = data.google_secret_manager_secret_version.iap_oauth2_client_secret.secret_data
    }
}

########################## URL Map ################################
resource "google_compute_url_map" "url-map" {
    project   = var.project_id
    name      = "${var.gke-dr-prefix}-url-map"
    default_service = google_compute_backend_service.backend-svc1.id
}

resource "google_compute_url_map" "url-map-http-redirect" {
    project   = var.project_id
    name      = "${var.gke-dr-prefix}-url-map-http-redirect"
    default_url_redirect {
      https_redirect         = true
      redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
      strip_query            = false
    }
}

########################## URL Map for internal haproxy ingress################################
resource "google_compute_url_map" "url-map-internal" {
    project   = var.project_id
    name      = "${var.gke-dr-prefix}-url-map-internal"
    default_service = google_compute_backend_service.backend-svc1-internal.id
}

resource "google_compute_url_map" "url-map-http-internal-redirect" {
    project   = var.project_id
    name      = "${var.gke-dr-prefix}-url-map-http-internal-redirect"
    default_url_redirect {
      https_redirect         = true
      redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
      strip_query            = false
    }
}

########################## HTTPS Proxy ################################
resource "google_compute_target_https_proxy" "target-https-proxy" {
    project          = var.project_id
    name             = "${var.gke-dr-prefix}-https-proxy"
    url_map          = google_compute_url_map.url-map.id
	ssl_certificates = [for cert in data.google_compute_ssl_certificate.https_proxy_cert : cert.certificate_id]
}

resource "google_compute_target_http_proxy" "target-http-proxy" {
    project          = var.project_id
    name             = "${var.gke-dr-prefix}-http-proxy"
    url_map          = google_compute_url_map.url-map-http-redirect.id
}

########################## HTTPS Proxy for internal haproxy ingress################################
resource "google_compute_target_https_proxy" "target-https-proxy-internal" {
    project          = var.project_id
    name             = "${var.gke-dr-prefix}-https-proxy-internal"
    url_map          = google_compute_url_map.url-map-internal.id
	ssl_certificates = [for cert in data.google_compute_ssl_certificate.https_proxy_cert : cert.certificate_id]
}

resource "google_compute_target_http_proxy" "target-http-proxy-internal" {
    project          = var.project_id
    name             = "${var.gke-dr-prefix}-http-proxy-internal"
    url_map          = google_compute_url_map.url-map-http-internal-redirect.id
}
################ Forwarding Rule #################################
resource "google_compute_global_forwarding_rule" "default" {
    project               = var.project_id
    name                  = "${var.gke-dr-prefix}-fwd-rule"
    ip_protocol           = var.lb_protocol
    load_balancing_scheme = var.lb_scheme 
    port_range            = var.lb_port_range
    target                = google_compute_target_https_proxy.target-https-proxy.id
    ip_address            = var.global_lb_ip
}

resource "google_compute_global_forwarding_rule" "default-redirect" {
    project               = var.project_id
    name                  = "${var.gke-dr-prefix}-fwd-rule-redirect"
    ip_protocol           = var.lb_protocol
    port_range            = 80 
    target                = google_compute_target_http_proxy.target-http-proxy.id
    ip_address            = var.global_lb_ip
}
################ Forwarding Rule for internal haproxy ingress#################################
resource "google_compute_global_forwarding_rule" "default-internal" {
    project               = var.project_id
    name                  = "${var.gke-dr-prefix}-fwd-rule-internal"
    ip_protocol           = var.lb_protocol
    load_balancing_scheme = var.lb_scheme 
    port_range            = var.lb_port_range
    target                = google_compute_target_https_proxy.target-https-proxy-internal.id
    ip_address            = var.global_lb_ip_internal
}

resource "google_compute_global_forwarding_rule" "default-internal-redirect" {
    project               = var.project_id
    name                  = "${var.gke-dr-prefix}-fwd-rule-internal-redirect"
    ip_protocol           = var.lb_protocol
    port_range            = 80
    target                = google_compute_target_http_proxy.target-http-proxy-internal.id
    ip_address            = var.global_lb_ip_internal
}
