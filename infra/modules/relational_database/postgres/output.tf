output "server_details" {
  value = {
    host = azurerm_postgresql_flexible_server.server.fqdn
  }
}