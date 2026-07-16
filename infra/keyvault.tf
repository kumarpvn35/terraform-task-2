module "key_vault" {
  source              = "./modules/key_vault"
  key_vault_name      = var.key_vault_name
  resource_group_name = var.key_vault_rg
  public_key_data     = file("${path.module}/sample.pub")
}