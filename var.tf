#Node Specifics

variable "agent_count" {
  default = 2
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
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

variable "cluster_location" {
  default = "northeurope"
}

variable resource_group_name {
  default = "akscluster"
}

variable location {
  default = "westeurope"
}

# Networking

variable custom_vnet {
  default = false
}

variable vnet_subnet_id {
  default = ""
}

# Set up Kubernetes SPN
variable "client_id" {}

variable "client_secret" {}
