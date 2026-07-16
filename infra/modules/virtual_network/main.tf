resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_config.name
  address_space       = var.vnet_config.address_space
  resource_group_name = var.vnet_config.resource_group.name
  location            = var.vnet_config.resource_group.location
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnet_config

  resource_group_name  = var.vnet_config.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefix
  name                 = each.value.name
  dynamic "delegation" {
    for_each = each.value.delication_config != null ? [each.value.delication_config] : []

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.details.name
        actions = delegation.value.details.actions
      }
    }
  }
}