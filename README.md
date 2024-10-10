# Azure App Configuration Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md)

This module manages Azure App Configuration stores using the [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) Terraform provider.

## Providers

| Name    | Version |
| ------- | ------- |
| azurerm | ~> 4.1. |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| Regions | TaleLearnCode/regions/azurerm | ~> .0.0.1-pre |

## Resources

No resources.

## Usage

```hcl
module "app_configuration" {
  source  = "TaleLearnCode/app_configuration/azurerm"
  version = "0.0.2-pre"
  providers = {
    azurerm = azurerm
  }
  
  location                       = local.location
  environment                    = local.environment
  resource_group_name            = data.azurerm_resoruce_group.rg.name
  srv_comp_abbr                  = local.srv_comp_abbr
  app_configuration_data_owners  = local.app_configuration_data_owners
}
```

For more detailed instructions on using this module: please refer to the appropriate example:

- [Default](examples/default/README.md)

## Inputs

| Name            | Description                                                  | Type   | Default | Required |
| ----------------------------- | ------------------------------------------------------------ | ------- | -------------- | -------- |
| current_user_object_id        | The object identifier of the current user.                   | string  | N/A            | yes      |
| custom_name                   | If set, the custom name to use instead of the generated name. | string  | NULL           | no       |
| environment                   | The environment where the resources are deployed to. Valid values are `dev`, `qa`, `e2e`, and `prod`. | string  | N/A            | yes      |
| location                      | The Azure Region in which all resources will be created      | string  | N/A            | yes      |
| name_prefix                   | Optional prefix to apply to the generated name.              | string  | ""             | no       |
| name_suffix                   | Optional suffix to apply to the generated name.              | string  | ""             | no       |
| purge_protection_enabled      | Should Purge Protection be enabled for this App Configuration? Defaults to false? | Boolean | false          | no       |
| resource_group_name           | The name of the Resource Group in which the Key Vault will be created. | string  | N/A            | yes      |
| service_principal_object_id   | The object identifier of the service principal.              | string  | N/A            | yes      |
| srv_comp_abbr                 | The abbreviation of the service or component for which the resources are being created for. | string  | NULL           | no       |
| tags                          | A map of tags to apply to all resources.                     | map     | N/A            | no       |
| soft_delete_retention_days    | The number of days that items should be retained for once soft-deleted. This field is only used for the 'standard' sku. | number  | 7              | no       |
| sku                           | The name of the SKU used for this App Configuration. Possible values are 'free' and 'standard'. Defaults to 'standard'. | string  | standard       | no       |
| local_auth_enabled            | Boolean flag to specify whether to enable local authentication. Default is true. | Boolean | true           | no       |
| public_network_access_enabled | Boolean flag to specify whether the App Configuration data is available over public network. Default is true. | Boolean | true           | no       |
| identity_type                 | The type of Managed Service Identity that should be assigned to the App Configuration. Possible values are 'SystemAssigned' and 'None'. Default is 'SystemAssigned'. | string  | SystemAssigned | no       |

## Outputs

| Name              | Description                             |
| ----------------- | --------------------------------------- |
| app_configuration | The managed App Configuration resource. |

# Naming Guidelines

### App Configuration

| Guideline                       |                                         |
| ------------------------------- | --------------------------------------- |
| Resource Type Identifier        | appcs                                   |
| Scope                           | Global                                  |
| Max Overall Length              | 5 - 50 characters                       |
| Allowed Component Name Length * | 30 characters                           |
| Valid Characters                | Alphanumeric, underscores, and hyphens. |
| Regex                           | `^[a-zA-Z0-9_-]{5,50}$`                 |

* Allowed Component Name Length is a combination of the `srv_comp_abbr`, `name_prefix`, and `name_suffix` or the `custom_name` if used.