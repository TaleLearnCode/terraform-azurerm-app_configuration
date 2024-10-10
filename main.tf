# #############################################################################
# Terraform Module: App Configuration Store
# #############################################################################

module "naming" {
  source  = "TaleLearnCode/naming/azurerm"
  version = "0.0.2-pre"

  resource_type  = "app_configuration"
  name_prefix    = var.name_prefix
  name_suffix    = var.name_suffix
  srv_comp_abbr  = var.srv_comp_abbr
  custom_name    = var.custom_name
  location       = var.location
  environment    = var.environment
}

resource "azurerm_app_configuration" "target" {
  name                       = module.naming.resource_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  sku                        = var.sku
  local_auth_enabled         = var.local_auth_enabled
  public_network_access      = var.public_network_access_enabled ? "Enabled" : "Disabled"
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days
  tags                       = var.tags
  dynamic "identity" {
    for_each = var.identity_type[*]
    content {
      type = var.identity_type
    }    
  }
}

resource "azurerm_role_assignment" "app_configuration_data_owners" {
  for_each             = length(var.app_configuration_data_owners) > 0 ? toset(var.app_configuration_data_owners) : toset([])
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = each.value

  depends_on = [
    azurerm_key_vault.key_vault
  ]
}
