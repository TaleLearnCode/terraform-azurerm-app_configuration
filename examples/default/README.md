# Example: Manging an App Configuration Store

This module manages an App Configuration store using the [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest) Terraform provider.  This example shows how to use the module to manage an Azure App Configuration store using a generated name.

## Example Usage

```hcl
locals {
  srv_comp_abbr                 = "eg"
  environment                   = "dev"
  location                      = "eastus"
  app_configuration_data_owners = [ "00000000-0000-0000-0000-000000000000" ]
}


data "azurerm_resoruce_group" "rg" {
  name = "rg-myresourcegroup-dev-usnc"
}

data "azurerm_client_config" "current" {}

data "azuread_service_principal" "terraform" {
  display_name = "Terraform-Catalog-Dev"
}

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

output "key_vault_name" {
  value = module.rg.name
  description = "The name of the Azure Key Vault."
}

output "key_vault_id" {
  value = module.rg.id
  description = "The identifier of the Azure Key Vault."
}

output "key_vault_location" {
  value = module.rg.location
  description = "The location of the Azure Key Vault."
}

output "key_vault_resouce_group_name" {
  value = module.rg.resource_group_name
  description = "The name of the resource group in which the Azure Key Vault is located."
}

output "key_vault_uri" {
  value = module.rg.vault_uri
  description = "The URI of the Azure Key Vault."
}
```

You are specifying three values:

- **srv_comp_abbr**: The abbreviation of the service component for which the resources are being created.

- **environment**: The environment where the resources are deployed to.

- **location**: The Azure Region in which all resources will be created.

- **resource_group_name**: The name of the Resource Group in which the App Configuration store will be created.

- **current_user_object_id**: Identifier of the user user executing the Terraform project. This user will be granted the `App Configuration Data Owner` role to the Azure App Configuration store.

- **service_principal_object_id**: Identifier of the Azure AD service principal used by Azure DevOps for executing the Terraform project. The service principal will be granted the `App Configuration Data Owner` role to the Azure App Configuration store.

This will result in an Azure Key Vault named: `appcs-myappconfig-dev-usnc`.