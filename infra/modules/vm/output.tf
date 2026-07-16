output "nic" {
  value = {id = azurerm_network_interface.nic.id
  ip_config_name = azurerm_network_interface.nic.ip_configuration[0].name
  }
}