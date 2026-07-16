module "vm" {
  source = "./modules/vm"

  for_each         = var.vm_config
  vm_name          = each.value.name
  subnet_id        = module.vnet[each.value.vnet].vnet.subnets[each.value.subnet].id
  resource_group   = module.rg[each.value.resource_group].rg
  nic_name         = each.value.nic_name
  nsg_id           = module.nsg[each.value.nsg_name].nsg.id
  public_key_value = module.key_vault.key_vault_secret.value
  public_ip_id     = module.public_ips[each.value.public_ip].public_ip.id
}