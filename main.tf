resource "tls_private_key" "ssh_key" {
  count     = "${var.create_ssh_key ? 1 : 0}"
  algorithm = "RSA"
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${replace(var.cluster_name, "#{REGION_ID}", lookup(var.location_name_map, var.cluster_locations))}"
  location            = "${var.cluster_locations}"
  resource_group_name = "${replace(var.resource_group_name, "#{REGION_ID}", lookup(var.location_name_map, var.cluster_location))}"
  dns_prefix          = "${var.dns_prefix}"
  kubernetes_version  = "${var.cluster_version}"

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = "${chomp(tls_private_key.ssh_key[0].public_key_openssh)}"
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = "${var.agent_count}"
    vm_size         = "${var.agent_size}"
    os_type         = "Linux"
    os_disk_size_gb = 30
    type            = "${var.nodepool_type}"
    vnet_subnet_id  = "${var.advanced_networking_enabled ? element(split(",", var.vnet_subnet_ids), count.index) : ""}"
  }

  network_profile {
    network_plugin = "${var.advanced_networking_enabled ? "azure" : "kubenet"}"
    network_policy = "${var.advanced_networking_enabled ? "azure" : ""}"
  }

  addon_profile {
    oms_agent {
      enabled                    = "${var.enable_oms}"
      log_analytics_workspace_id = "${azurerm_log_analytics_workspace.test.id}"
    }
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }
}
