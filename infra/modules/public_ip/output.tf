output "public_ip" {
  value = {
    id      = azurerm_public_ip.public_ip.id
    name    = azurerm_public_ip.public_ip.name
    address = azurerm_public_ip.public_ip.ip_address
  }
}