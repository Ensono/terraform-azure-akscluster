resource "tls_private_key" "ssh_key" {
  count     = "${var.create_ssh_key ? 1 : 0 }"
  algorithm = "RSA"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  lifecycle = {
    ignore_changes = "id"
  }

  count               = "${length(local.cluster_location_list)}"
  name                = "${replace(var.cluster_name, "#{REGION_ID}", lookup(var.location_name_map, local.cluster_location_list[count.index]))}"
  location            = "${element(local.cluster_location_list,count.index)}"
  resource_group_name = "${replace(var.resource_group_name, "#{REGION_ID}", lookup(var.location_name_map, local.cluster_location_list[count.index]))}"
  dns_prefix          = "${var.dns_prefix}"
  kubernetes_version  = "${var.cluster_version}"
  
  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = "${chomp(tls_private_key.ssh_key.public_key_openssh)}"
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = "${var.agent_count}"
    vm_size         = "${var.agent_size}"
    os_type         = "Linux"
    os_disk_size_gb = 30
    vnet_subnet_id  = "${var.custom_vnet ? element(split(",", var.vnet_subnet_ids),count.index) : "" }"
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }
}
