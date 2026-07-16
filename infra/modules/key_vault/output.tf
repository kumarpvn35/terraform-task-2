output "key_vault_secret" {
  value = {
    name  = azurerm_key_vault_secret.ssh-public-key.name
    value = azurerm_key_vault_secret.ssh-public-key.value
  }
}