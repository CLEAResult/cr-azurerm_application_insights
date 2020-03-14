resource "azurerm_application_insights" "appinsights" {
  name                                  = format("%s%03d", local.name, count.index + 1)
  count                                 = var.num
  location                              = "eastus"
  resource_group_name                   = var.rg_name
  application_type                      = var.application_type
  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.daily_data_cap_notifications_disabled
  retention_in_days                     = var.retention_in_days
  sampling_percentage                   = var.sampling_percentage

  lifecycle {
    ignore_changes = [tags]
  }

  tags = {
    InfrastructureAsCode = "True"
  }
}

resource "azuread_group" "applicationinsightscomponentcontributor" {
  name = format("g%s%s%s_AZ_ApplicationInsightsComponentContributor", local.default_rgid, local.env_id, local.rg_type)
}

resource "azurerm_role_assignment" "applicationinsightscomponentcontributor" {
  scope                = format("/subscriptions/%s/resourceGroups/%s", var.subscription_id, var.rg_name)
  role_definition_name = "Application Insights Component Contributor"
  principal_id         = azuread_group.applicationinsightscomponentcontributor.id
}

