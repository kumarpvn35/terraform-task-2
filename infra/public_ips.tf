module "public_ips" {
  source   = "./modules/public_ip"
  for_each = var.public_ips

  public_ip_name = each.value.name
  resource_group = module.rg[each.value.resource_group].rg
}