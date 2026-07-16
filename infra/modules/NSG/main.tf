resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}


resource "azurerm_network_security_rule" "rules" {
  for_each = var.rules

  name                        = each.value.name
  resource_group_name         = var.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  protocol                    = each.value.protocol
  direction                   = each.value.direction
  priority                    = each.value.priority
  access                      = each.value.access
  source_port_range           = each.value.source_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_port_range      = each.value.destination_port_range
  destination_address_prefix  = each.value.destination_address_prefix
}