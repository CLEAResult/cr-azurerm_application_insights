variable "rgid" {
  type        = string
  description = "RGID used for naming."
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Location for resources to be created"
}

variable "num" {
  type        = number
  default     = 1
  description = "Number of resources to be created"
}

variable "name_prefix" {
  type        = string
  default     = ""
  description = "Allows users to override the standard naming prefix.  If left as an empty string, the standard naming conventions will apply."
}

variable "name_suffix" {
  type        = string
  default     = ""
  description = "Allows users to override the standard naming suffix, appearing after the instance count.  If left as an empty string, the standard naming conventions will apply."
}

variable "name_override" {
  type        = string
  default     = ""
  description = "If non-empty, will override all the standard naming conventions.  This should only be used when a product requires a specific database name."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment used in naming lookups"
}

variable "rg_name" {
  type        = string
  description = "Resource group name"
}

variable "subscription_id" {
  type        = string
  description = "Prompt for subscription ID"
}

variable "application_type" {
  type        = string
  default     = "other"
  description = "Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created. Default is other."
}

variable "daily_data_cap_in_gb" {
  type        = number
  default     = 100
  description = "Specifies the Application Insights component daily data volume cap in GB. Default is 100GB. Per Microsoft: \"Use care when you set the daily cap. Your intent should be to never hit the daily cap. If you hit the daily cap, you lose data for the remainder of the day, and you can't monitor your application.\""
}

variable "daily_data_cap_notifications_disabled" {
  type        = bool
  default     = false
  description = "Specifies if a notification email will be send when the daily data volume cap is met. Default is false. Notifications will be sent to the default roles set by Microsoft."
}

variable "retention_in_days" {
  type        = number
  default     = 90
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Default is 90."
}

variable "sampling_percentage" {
  type        = number
  default     = 100
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry. Default is 100 percent."
}

variable "disable_ip_masking" {
  type        = bool
  default     = false
  description = "By default the real client ip is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client ip. Defaults to false."
}

# Compute default name values
locals {
  env_id = lookup(module.naming.env-map, var.environment, "env")
  type = lookup(
    module.naming.type-map,
    "azurerm_application_insights",
    "typ",
  )

  rg_type = lookup(module.naming.type-map, "azurerm_resource_group", "typ")

  default_rgid        = var.rgid != "" ? var.rgid : "norgid"
  default_name_prefix = format("c%s%s", local.default_rgid, local.env_id)

  name_prefix = var.name_prefix != "" ? var.name_prefix : local.default_name_prefix
  name        = format("%s%s", local.name_prefix, local.type)
}

# This module provides a data map output to lookup naming standard references
module "naming" {
  source = "git::https://github.com/CLEAResult/cr-azurerm-naming.git?ref=v1.1.2"
}

