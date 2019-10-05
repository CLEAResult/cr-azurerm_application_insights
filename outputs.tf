output "instrumentation_key" {
  value = azurerm_application_insights.appinsights.*.instrumentation_key
}

output "id" {
  value = azurerm_application_insights.appinsights.*.id
}

output "app_id" {
  value = azurerm_application_insights.appinsights.*.app_id
}

output "applicationinsightscomponentcontributorId" {
  value = azuread_group.applicationinsightscomponentcontributor.*.id
}

output "applicationinsightscomponentcontributorName" {
  value = azuread_group.applicationinsightscomponentcontributor.*.name
}

