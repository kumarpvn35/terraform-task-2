module "rg" {
  source = "./modules/resource_group"
  for_each = var.resource_groups

  name = each.value.name
  location = each.value.location
}