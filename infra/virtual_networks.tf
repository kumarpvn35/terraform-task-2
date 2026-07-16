module "vnet" {
  source = "./modules/virtual_network"
  for_each = var.virtual_networks

  vnet_config = {
    name = each.value.name
    address_space = each.value.address_space
    resource_group = module.rg[each.value.resource_group].rg
  }
  subnet_config = each.value.subnets
}