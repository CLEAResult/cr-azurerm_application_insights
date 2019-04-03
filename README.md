# cr-azurerm_application_insights

Creates an Azure application insights instance.

# Required Input Variables

* `rgid` - RGID - used in naming standard
* `rg_name` - resource group name

# Example

```
variable "rgid" {
  default = "99999"
}

variable "rg_name" {
  default = "somegroup"
}

module "rg" {
  source = "git::ssh://git@github.com/clearesult/cr-azurerm_resource_group.git"
  rgid = "${var.rgid}"
  rg_name = "${var.rg_name}"
}
```
