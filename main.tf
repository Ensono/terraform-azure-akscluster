resource "tls_private_key" "ssh_key" {
  count     = "${var.create_resource ? 1 : 0 }"
  algorithm = "RSA"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  count               = "${var.create_resource ? 1 : 0 }"
  name                = "${var.cluster_name}"
  location            = "${var.cluster_location}"
  resource_group_name = "${var.resource_group_name}"
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
    vnet_subnet_id  = "${var.custom_vnet ? var.vnet_subnet_id : "" }"
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }
}
