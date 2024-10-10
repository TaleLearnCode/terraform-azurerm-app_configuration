# #############################################################################
# Variables: App Configuration
# #############################################################################

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the Key Vault will be created."
}

variable "soft_delete_retention_days" {
  type        = number
  default     = 7
  description = "The number of days that items should be retained for once soft-deleted. This field is only used for the 'standard' sku. This value can be between 1 and 7 (the default) days."
}

variable "purge_protection_enabled" {
  type        = bool
  default     = false
  description = "Should Purge Protection be enabled for this App Configuration? Defaults to false?"
}
#
variable "sku" {
  type        = string
  default     = "standard"
  description = "The name of the SKU used for this App Configuration. Possible values are 'free' and 'standard'. Defaults to 'standard'."
}

variable "local_auth_enabled" {
  type        = bool
  default     = true
  description = "Boolean flag to specify whether to enable local authentication. Default is true."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Boolean flag to specify whether the App Configuration data is available over public network. Default is true."
}

variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "The type of Managed Service Identity that should be assigned to the App Configuration. Possible values are 'SystemAssigned' and 'None'. Default is 'SystemAssigned'."
}