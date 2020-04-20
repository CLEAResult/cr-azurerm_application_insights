provider "random" {
  version = "~> 2.1"
}

resource "random_string" "test" {
  length  = 9
  special = false
  upper   = false
  lower   = true
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  features {}
}

module "rg" {
  source          = "git::https://github.com/clearesult/cr-azurerm_resource_group.git?ref=v1.2.3"
  rgid            = var.rgid
  environment     = var.environment
  location        = var.location
  create_date     = var.create_date
  subscription_id = var.subscription_id
}

module "appinsights" {
  source          = "../../"
  rg_name         = basename(module.rg.id)
  rgid            = var.rgid
  environment     = var.environment
  location        = var.location
  subscription_id = var.subscription_id
  name_prefix     = format("%s2", random_string.test.result)
  name_suffix     = "testapp"
}

module "appinsights-override" {
  source          = "../../"
  rg_name         = basename(module.rg.id)
  rgid            = var.rgid
  environment     = var.environment
  location        = var.location
  subscription_id = var.subscription_id
  name_override   = format("override%s", random_string.test.result)
}
