resource "azurerm_application_insights" "appinsights" {
  name                = format("%s%03d", local.name, count.index + 1)
  count               = var.num
  location            = "eastus"
  resource_group_name = var.rg_name
  application_type    = "Web"

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

