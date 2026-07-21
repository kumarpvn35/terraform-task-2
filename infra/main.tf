terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}


module "rg" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
}


module "vnet" {
  source   = "./modules/virtual_network"
  for_each = var.virtual_networks

  vnet_config = {
    name           = each.value.name
    address_space  = each.value.address_space
    resource_group = module.rg[each.value.resource_group].rg
  }
  subnet_config = each.value.subnets
}



module "database" {
  source   = "./modules/relational_database/postgres"
  for_each = var.database

  config             = each.value.config
  resource_group     = module.rg[each.value.resource_group].rg
  subnet_id          = module.vnet[each.value.virtual_network].vnet.subnets[each.value.subnet].id
  virtual_network_id = module.vnet[each.value.virtual_network].vnet.id
}


module "key_vault" {
  source   = "./modules/key_vault"
  for_each = var.vault_secrets

  key_vault_name      = each.value.key_vault_name
  name                = each.value.name
  resource_group_name = each.value.rg
  public_key_data     = file("${path.module}/sample.pub")
}



module "nsg" {
  source   = "./modules/NSG"
  for_each = var.network_security_groups

  name           = each.value.name
  resource_group = module.rg[each.value.resource_group].rg
}


module "public_ips" {
  source   = "./modules/public_ip"
  for_each = var.public_ips

  public_ip_name = each.value.name
  resource_group = module.rg[each.value.resource_group].rg
}


module "vm" {
  source = "./modules/vm"

  for_each         = var.vm_config
  vm_name          = each.value.name
  subnet_id        = module.vnet[each.value.vnet].vnet.subnets[each.value.subnet].id
  resource_group   = module.rg[each.value.resource_group].rg
  nic_name         = each.value.nic_name
  nsg_id           = module.nsg[each.value.nsg_name].nsg.id
  public_key_value = module.key_vault[each.value.key_name].key_vault_secret.value
  public_ip_id     = module.public_ips[each.value.public_ip].public_ip.id
}


module "nsg_rules" {
  for_each = var.nsg_rules

  source         = "./modules/NSG_rules"
  rule_config    = each.value
  resource_group = module.rg[each.value.rg].rg
  nsgs = [
    for nsg_name in each.value.nsgs :
    module.nsg[nsg_name].nsg.name
  ]
}