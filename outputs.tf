# #############################################################################
# Outputs
# #############################################################################

output "app_configuration" {
  description = "The managed App Configuration resource."
  value       = azurerm_app_configuration.target
}