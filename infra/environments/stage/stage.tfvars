key_vault_name = "key-vault-8025"
key_vault_rg   = "manual"

resource_groups = {
  "rg1" = {
    name     = "resource_group_stage"
    location = "centralindia"
  }
}


virtual_networks = {
  "vnet1" = {
    name           = "virtual_network_stage"
    address_space  = ["10.0.0.0/16"]
    resource_group = "rg1"
    subnets = {
      "subnet1" = {
        name           = "subnet_stage"
        address_prefix = ["10.0.0.0/25"]
      }
      "postgres_subnet" = {
        name           = "postgres_subnet_stage"
        address_prefix = ["10.0.0.128/28"]
        delication_config = {
          name = "db_deligation"
          details = {
            name    = "Microsoft.DBforPostgreSQL/flexibleServers"
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
          }
        }
      }
    }
  }
}


database = {
}



network_security_groups = {
  "nsg1" = {
    name           = "network_security_group_stage"
    resource_group = "rg1"
    rules = {
      "rule1" = {
        name                       = "allow_http_stage"
        protocol                   = "Tcp"
        direction                  = "Inbound"
        priority                   = 101
        access                     = "Allow"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_port_range     = "80"
        destination_address_prefix = "*"
      }
      "rule2" = {
        name                       = "allow_https_stage"
        protocol                   = "Tcp"
        direction                  = "Inbound"
        priority                   = 102
        access                     = "Allow"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_port_range     = "443"
        destination_address_prefix = "*"
      }

      "rule3" = {
        name                       = "allow_ssh_stage"
        protocol                   = "Tcp"
        direction                  = "Inbound"
        priority                   = 103
        access                     = "Allow"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_port_range     = "22"
        destination_address_prefix = "*"
      }
    }
  }
}


vm_config = {
  "vm1" = {
    name           = "dotnet-vm-stage"
    vnet           = "vnet1"
    subnet         = "subnet1"
    resource_group = "rg1"
    nic_name       = "dotnet-nic-stage"
    nsg_name       = "nsg1-stage"
    public_ip      = "ip1"
  }
}


public_ips = {
  "ip1" = {
    name           = "public-ip-for-dotnet-stage"
    resource_group = "rg1"
  }
}