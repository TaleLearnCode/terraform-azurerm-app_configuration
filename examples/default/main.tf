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