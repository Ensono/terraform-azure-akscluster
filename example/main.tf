provider "azurerm" {}

resource "random_pet" "name" {
  length    = 2
  separator = ""
  prefix    = "aks"
}

module "aks-cluster" {
  source = "git::https://github.com/amido/terraform-azure-akscluster.git"

  cluster_name        = "${random_pet.name.id}"
  agent_count         = "${var.cluster_agent_count}"
  location            = "${var.resource_group_location}"
  resource_group_name = "${random_pet.name.id}"
  client_id           = "${var.cluster_spn_clientid}"
  client_secret       = "${var.cluster_spn_clientsecret}"
  tags                = "${var.resource_group_tags}"
}
