output "nsg" {
  value = {
    id   = azurerm_network_security_group.nsg.id
    name = azurerm_network_security_group.nsg.name
    rules = {
      for key, rule in azurerm_network_security_rule.rules :
      key => {
        id   = rule.id
        name = rule.name
      }
    }
  }
}