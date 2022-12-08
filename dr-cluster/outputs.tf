output "kubernetes_cluster1_name" {
  value       = module.gke-dr-pri-cluster-1.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster1_host" {
  value       = module.gke-dr-pri-cluster-1.kubernetes_cluster_host
  description = "GKE Cluster Host"
}

output "kubernetes_cluster2_name" {
  value       = module.gke-dr-pri-cluster-2.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster2_host" {
  value       = module.gke-dr-pri-cluster-2.kubernetes_cluster_host
  description = "GKE Cluster Host"
}
