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
