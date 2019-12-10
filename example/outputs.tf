output "AKS-cluster-host" {
  value = "${module.aks-cluster.k8s_endpoint}"
}
