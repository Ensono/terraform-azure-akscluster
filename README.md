# Amido Azure AKS Cluster Terraform module


Terraform module which creates AKS Cluster resources on Azure.

## Example Usage

```hcl
module "aks-cluster" {
  source = "/modules/terraform-azure-akscluster"

  cluster_name        = "${var.resource_group_name}"
  agent_count         = "${var.cluster_agent_count}"
  location            = "${var.resource_group_location}"
  resource_group_name = "${var.resource_group_name}"
  client_id           = "${var.cluster_spn_clientid}"
  client_secret       = "${var.cluster_spn_clientsecret}"
  tags                = "${var.resource_group_tags}"
  
}
```

## Provisioning Result

Without any variables, this module will provision a 2 node cluster in West Europe, returning the key data as outputs.

## Terraform version

This has been tested in AzureRM provider version 1.9.0 and Terraform 0.11.7

## Examples

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

TODO: Establish hook to write this section!

## Outputs

TODO: Establish hook to write this section!

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Tests

TODO: Establish Terraform testing framework


## Authors

Module is maintained by [William Ayerst](https://github.com/williamayerst).

## License

Apache 2 Licensed. See LICENSE for full details.

