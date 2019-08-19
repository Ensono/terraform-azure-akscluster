#Node Specifics

variable "agent_count" {
  default = 2
}

variable "create_ssh_key" {
  default = true
  type    = bool
}

variable "agent_size" {
  default = "Standard_D2"
}

# can be either AvailabilitySet or VirtualMachineScaleSets 
# VirtualMachineScaleSets must be enabled whilst in preview using the following command
# az feature show --namespace Microsoft.ContainerService --name VMSSPreview
variable "nodepool_type" {
  default = "AvailabilitySet"
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
  default = true
  type    = bool

}

variable vnet_subnet_ids {
  type = "string"
}

# Set up Kubernetes SPN
variable "client_id" {}

variable "client_secret" {}

variable "cluster_location" {
  default = "uksouth"
}

variable "enable_oms" {
  default = false
  type = bool
}
variable "oms_workspace" {
  default = ""
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
