output "vnet" {
  value = {
    id   = azurerm_virtual_network.vnet.id
    name = azurerm_virtual_network.vnet.name
    subnets = {
      for key, subnet in azurerm_subnet.subnet :
      key => {
        id   = subnet.id
        name = subnet.name
      }
    }
  }
}
