variable "resource_group_location" {
  default = "northeurope"
}

variable "resource_group_tags" {
  type = "map"

  default = {
    environment = "reference"
  }
}

variable "cluster_agent_count" {
  default = 2
}

variable "cluster_spn_clientid" {}

variable "cluster_spn_clientsecret" {}
