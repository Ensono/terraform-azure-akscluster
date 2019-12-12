resource "tls_private_key" "ssh_key" {
  count     = var.create_ssh_key ? 1 : 0
  algorithm = "RSA"
}

resource "azurerm_kubernetes_cluster" "k8s_auto_scaled" {
  count               = var.enable_auto_scaling ? 1 : 0
  name                = replace(var.cluster_name, "#{REGION_ID}", lookup(var.location_name_map, var.cluster_location))
  location            = var.cluster_location
  resource_group_name = replace(var.resource_group_name, "#{REGION_ID}", lookup(var.location_name_map, var.cluster_location))
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.cluster_version

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = chomp(tls_private_key.ssh_key[0].public_key_openssh)
    }
  }

  default_node_pool {
    # TODO: variablise below:
    # availability_zones    =
    # node_taints           = [] -> null
    # max_pods        = var.max_pods != 0 ? var.max_pods : 1
    # enable_node_public_ip = false
    type                = var.nodepool_type # "VirtualMachineScaleSets" # default
    enable_auto_scaling = true
    max_count           = var.max_nodes
    min_count           = var.min_nodes
    name                = "default"
    os_disk_size_gb     = var.os_disk_size
    vm_size             = var.agent_size
    vnet_subnet_id = var.vnet_subnet_id
  }

  network_profile {
    network_plugin = var.advanced_networking_enabled ? "azure" : "kubenet"
    network_policy = var.advanced_networking_enabled ? "azure" : ""
  }

  addon_profile {
    dynamic "oms_agent" {
      for_each = var.oms_ws_list_of_one
      content {
        enabled                    = lookup(oms_agent.value, "enabled")
        log_analytics_workspace_id = lookup(oms_agent.value, "oms_workspace_id")
      }
    }
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}


resource "azurerm_kubernetes_cluster" "k8s" {
  count               = var.enable_auto_scaling ? 0 : 1
  name                = replace(var.cluster_name, "#{REGION_ID}", lookup(var.location_name_map, var.cluster_location))
  location            = var.cluster_location
  resource_group_name = replace(var.resource_group_name, "#{REGION_ID}", lookup(var.location_name_map, var.cluster_location))
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.cluster_version

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = chomp(tls_private_key.ssh_key[0].public_key_openssh)
    }
  }

  default_node_pool {
    enable_auto_scaling = false
    name                = "default"
    node_count          = var.node_count != 0 ? var.node_count : var.agent_count # backwards compatibility
    os_disk_size_gb     = var.os_disk_size != 0 ? var.os_disk_size : 30 # this should be configurable
    vm_size             = var.agent_size
    vnet_subnet_id      = var.vnet_subnet_id
    type                = var.nodepool_type
  }

  network_profile {
    network_plugin = var.advanced_networking_enabled ? "azure" : "kubenet"
    network_policy = var.advanced_networking_enabled ? "azure" : ""
  }

  addon_profile {
    oms_agent{
     enabled                      = true
      log_analytics_workspace_id  = var.oms_workspace
    }
  }

  # TODO: MAKE THIS WORK
  # dynamic "addon_profile" {
  #   for_each = var.oms_ws_list_of_one
  #     content {
  #       oms_agent {
  #         enabled                    = lookup(oms_agent.value, "enabled")
  #         log_analytics_workspace_id = lookup(oms_agent.value, "oms_workspace_id")
  #       }
  #     }
  # }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  lifecycle {
    ignore_changes = [agent_pool_profile]
  }
}
