output "instrumentation_key" {
  value = "${azurerm_application_insights.appinsights.*.instrumentation_key}"
}

output "app_id" {
  value = "${azurerm_application_insights.appinsights.*.app_id}"
}

output "applicationinsightscomponentcontributorId" {
  value = "${azuread_group.applicationinsightscomponentcontributor.id}"
}