provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  version         = ">=1.38"
}

data "azurerm_virtual_network" "default" {
  name                = var.vnet_id
  resource_group_name = var.rg_name
}

data "azurerm_subnet" "default" {
  name                 = element(data.azurerm_virtual_network.default.subnets, 0)
  virtual_network_name = var.vnet_id
  resource_group_name  = var.rg_name
}


resource "random_pet" "name" {
  length    = 2
  separator = ""
  prefix    = "aks"
}

resource "azurerm_resource_group" "default" {
  name     = random_pet.name.id
  location = var.resource_group_location

  tags = {
    environment = "example-test"
  }
}

resource "azurerm_log_analytics_workspace" "default" {
  name                = random_pet.name.id
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

module "aks-cluster" {
  # source = "git::https://github.com/amido/terraform-azure-akscluster.git=ref=v1.0.0"
  source              = "../"
  cluster_name        = "${random_pet.name.id}-#{REGION_ID}"
  agent_count         = var.cluster_agent_count
  cluster_version     = "1.14.8"
  enable_oms          = true
  enable_auto_scaling = var.enable_auto_scaling
  oms_workspace       = azurerm_log_analytics_workspace.default.id
  # sample workspace creation if enabled
  oms_ws_list_of_one = [
    { enabled          = "true",
      oms_workspace_id = azurerm_log_analytics_workspace.default.id
    }
  ]
  # oms_ws_list_of_one  = []
  resource_group_name = var.rg_name
  client_id           = var.client_id
  client_secret       = var.client_secret
  tags                = var.resource_group_tags
  agent_size          = "Standard_D3_v2"
  # this should really be an array... but anyway
  # legacy param `vnet_subnet_ids`
  vnet_subnet_ids = data.azurerm_subnet.default.id
  # default_node_pool requires a subnet_id - IT IS NO LONGER OPTIONAL
  vnet_subnet_id   = data.azurerm_subnet.default.id
  cluster_location = var.resource_group_location
}
