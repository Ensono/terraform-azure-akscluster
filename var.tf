#Node Specifics

variable "agent_count" {
  default = 2
}

variable "create_ssh_key" {
  default = true
}

variable "agent_size" {
  default = "Standard_D2"
}

variable "dns_prefix" {
  default = "aks"
}

variable "tags" {
  type    = "map"
  default = {}
}

# Cluster and resource specifics
variable cluster_name {
  default = "akscluster"
}

variable cluster_version {
  default = ""
}
variable resource_group_name {
  default = "akscluster"
}

# Networking

variable advanced_networking_enabled {
  default = false
}

variable vnet_subnet_ids {
  type = "string"
}

# Set up Kubernetes SPN
variable "client_id" {}

variable "client_secret" {}

variable "cluster_locations" {
  default = "northeurope,westeurope"
}

variable "location_name_map" {
  type = "map"

  default = {
    northeurope = "eun"
    westeurope  = "euw"
    uksouth     = "uks"
    ukwest      = "ukw"
  }
}

locals {
  cluster_location_list = "${compact(split(",",var.cluster_locations))}"
}
