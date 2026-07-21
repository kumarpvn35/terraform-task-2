resource_groups = {
  "rg1" = {
    name     = "resource_group_prod"
    location = "centralindia"
  }
  "rg2" = {
    name     = "resource_group_prod_2"
    location = "centralindia"
  }
}


virtual_networks = {
  "vnet1" = {
    name           = "virtual_network_prod"
    address_space  = ["10.0.0.0/16"]
    resource_group = "rg1"
    subnets = {
      "subnet1" = {
        name           = "subnet_prod"
        address_prefix = ["10.0.0.0/25"]
      }
      "postgres_subnet" = {
        name           = "postgres_subnet_prod"
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
    name           = "network_security_group_prod"
    resource_group = "rg1"
  }
}

nsg_rules = {
  "rule1" = {
    name                       = "allow_http"
    protocol                   = "Tcp"
    direction                  = "Inbound"
    priority                   = 101
    access                     = "Allow"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "80"
    destination_address_prefix = "*"
    nsgs                       = ["nsg1"]
    rg                         = "rg1"
  }
  "rule2" = {
    name                       = "allow_https"
    protocol                   = "Tcp"
    direction                  = "Inbound"
    priority                   = 102
    access                     = "Allow"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "443"
    destination_address_prefix = "*"
    nsgs                       = ["nsg1"]
    rg                         = "rg1"
  }

  "rule3" = {
    name                       = "allow_ssh"
    protocol                   = "Tcp"
    direction                  = "Inbound"
    priority                   = 103
    access                     = "Allow"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "22"
    destination_address_prefix = "*"
    nsgs                       = ["nsg1"]
    rg                         = "rg1"
  }
}


vm_config = {
  "vm1" = {
    name           = "dotnet-vm-prod"
    vnet           = "vnet1"
    subnet         = "subnet1"
    resource_group = "rg1"
    nic_name       = "dotnet-nic-prod"
    nsg_name       = "nsg1"
    public_ip      = "ip1"
    key_name       = "secret1"
  }
}


public_ips = {
  "ip1" = {
    name           = "public-ip-for-dotnet-prod"
    resource_group = "rg1"
  }
}


vault_secrets = {
  "secret1" = {
    name           = "ssh-prod"
    rg             = "manual"
    key_vault_name = "key-vault-8025"
  }
}
