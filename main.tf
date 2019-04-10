resource "azurerm_application_insights" "appinsights" {
  count               = "${var.count != "" ? var.count : "1"}"
  name                = "${local.name}${format("%3d", count.index)}"
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
