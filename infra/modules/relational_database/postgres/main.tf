resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "${var.config.name}-private.postgres.database.azure.com"
  resource_group_name = var.resource_group.name
}


resource "azurerm_private_dns_zone_virtual_network_link" "private_link" {
  name                  = "${var.config.name}VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group.name
}


resource "azurerm_postgresql_flexible_server" "server" {
  name                          = var.config.name
  resource_group_name           = var.resource_group.name
  location                      = var.resource_group.location
  version                       = var.config.version
  administrator_login           = var.config.username
  administrator_password        = var.config.password
  storage_mb                    = var.config.storage_size
  sku_name                      = var.config.sku_name
  delegated_subnet_id           = var.subnet_id
  public_network_access_enabled = false
  private_dns_zone_id           = azurerm_private_dns_zone.dns_zone.id

  depends_on = [azurerm_private_dns_zone_virtual_network_link.private_link]
}
