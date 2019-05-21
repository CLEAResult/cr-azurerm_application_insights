resource "azurerm_application_insights" "appinsights" {
  name                = "${local.name}${format("%03d", count.index + 1)}"
  count               = "${var.count}"
  location            = "eastus"
  resource_group_name = "${var.rg_name}"
  application_type    = "Web"

  lifecycle {
    ignore_changes = [
      "tags",
    ]
  }

  tags {
    InfrastructureAsCode = "True"
  }
}

resource "azuread_group" "applicationinsightscomponentcontributor" {
    name = "g${local.default_rgid}${local.env_id}${local.rg_type}_ApplicationInsightsComponentContributor"
}

resource "azurerm_role_assignment" "applicationinsightscomponentcontributor" {
  scope              = "/subscriptions/${var.subscription_id}/resourceGroups/${var.rg_name}"
  role_definition_name = "Application Insights Component Contributor"
  principal_id       = "${azuread_group.applicationinsightscomponentcontributor.id}"
}
