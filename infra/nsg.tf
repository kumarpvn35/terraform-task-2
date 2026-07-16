module "nsg" {
  source = "./modules/NSG"
  for_each = var.network_security_groups

  name = each.value.name
  rules = each.value.rules
  resource_group = module.rg[each.value.resource_group].rg
}