variable "client_id" {}
variable "client_secret" {}

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
