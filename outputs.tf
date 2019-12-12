output "k8s_id" {
  value = lookup(element(azurerm_kubernetes_cluster.k8s, 0), "id")
}

output "k8s_endpoint" {
  value = lookup(element(azurerm_kubernetes_cluster.k8s, 0), "fqdn")
}

output "k8s_private_key_pem" {
  value = chomp(element(concat(tls_private_key.ssh_key.*.private_key_pem, list("")), 0))
}
