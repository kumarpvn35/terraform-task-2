
resource "azurerm_network_security_rule" "rule" {
  for_each = toset(var.nsgs)

  name                        = var.rule_config.name
  resource_group_name         = var.resource_group.name
  network_security_group_name = each.value
  protocol                    = var.rule_config.protocol
  direction                   = var.rule_config.direction
  priority                    = var.rule_config.priority
  access                      = var.rule_config.access
  source_address_prefix       = var.rule_config.source_address_prefix
  destination_port_range      = var.rule_config.destination_port_range
  source_port_range           = var.rule_config.source_port_range
  destination_address_prefix  = var.rule_config.destination_address_prefix
}