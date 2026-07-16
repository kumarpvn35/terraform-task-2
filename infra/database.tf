# module "database" {
#   source = "./modules/relational_database/postgres"
#   for_each = var.database

#   config = each.value.config
#   resource_group = module.rg[each.value.resource_group].rg
#   subnet_id = module.vnet[each.value.virtual_network].vnet.subnets[each.value.subnet].id
#   virtual_network_id = module.vnet[each.value.virtual_network].vnet.id
# }