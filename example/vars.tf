variable "resource_group_location" {
  default = "westeurope"
}

variable "resource_group_tags" {
  type = map(string)
  default = {
    environment = "reference"
  }
}

variable "cluster_agent_count" {
  default = 2
}

variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}

variable "rg_name" {}

variable "vnet_id" {}

variable "enable_auto_scaling" {
  type    = bool
  default = false
}

variable "max_nodes" {
  type    = number
  default = 100
}
