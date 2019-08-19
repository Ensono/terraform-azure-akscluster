output "k8s_id" {
  value = "${azurerm_kubernetes_cluster.k8s.id}"
}

output "k8s_endpoint" {
  value = "${azurerm_kubernetes_cluster.k8s.fqdn}"
}

output "k8s_private_key_pem" {
  value = "${chomp(element(concat(tls_private_key.ssh_key.*.private_key_pem, list("")),0))}"
}
