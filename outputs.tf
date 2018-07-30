output "k8s_id" {
  value = "${element(concat(azurerm_kubernetes_cluster.k8s.*.id, list("")), 0)}"
}

output "k8s_endpoint" {
  value = "${element(concat(azurerm_kubernetes_cluster.k8s.*.fqdn, list("")), 0)}"
}

output "k8s_private_key_pem" {
  value = "${element(concat(chomp(tls_private_key.ssh_key.*.private_key_pem), list("")), 0)}"
}
