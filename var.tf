#Node Specifics

variable "agent_count" {
  default = 2
}

variable "create_ssh_key" {
  type    = bool
  default = true
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
  type    = map(string)
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
  type = string
}

variable vnet_subnet_id {
  type    = string
  default = ""
}

# Set up Kubernetes SPN
variable "client_id" {}

variable "client_secret" {}

variable "cluster_location" {
  type    = string
  default = "uksouth"
}

variable "enable_oms" {
  default = false
  type    = bool
}
variable "oms_workspace" {
  type    = string
  default = ""
}

variable "location_name_map" {
  type = map(string)

  default = {
    northeurope = "eun"
    westeurope  = "euw"
    uksouth     = "uks"
    ukwest      = "ukw"
  }
}

variable "enable_auto_scaling" {
  type    = bool
  default = false
}


variable "max_pods" {
  type    = number
  default = 100
}

variable "max_nodes" {
  type    = number
  default = 10
}

variable "min_nodes" {
  type    = number
  default = 1
}

variable "node_count" {
  type    = number
  default = 0
}

# DEFAULTS TO 30 if not overwritten
variable "os_disk_size" {
  type    = number
  default = 30
}

variable "oms_ws_list_of_one" {
  type    = list(map(string))
  default = [{}]
}
