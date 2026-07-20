data "azurerm_key_vault" "vault" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault_secret" "ssh-public-key" {
  name         = var.name
  value        = var.public_key_data
  key_vault_id = data.azurerm_key_vault.vault.id
}