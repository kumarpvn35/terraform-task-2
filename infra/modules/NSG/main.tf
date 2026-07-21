resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}