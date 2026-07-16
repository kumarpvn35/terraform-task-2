key_vault_name = "key-vault-8025"
key_vault_rg   = "manual"

resource_groups = {
  "rg1" = {
    name     = "resource_group_1"
    location = "centralindia"
  }
}


virtual_networks = {
  "vnet1" = {
    name           = "virtual_network_1"
    address_space  = ["10.0.0.0/16"]
    resource_group = "rg1"
    subnets = {
      "subnet1" = {
        name           = "subnet_1"
        address_prefix = ["10.0.0.0/25"]
      }
      "postgres_subnet" = {
        name           = "postgres_subnet"
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
  "database1" = {
    config = {
      name         = "test-database-8025"
      version      = "16"
      username     = "kumarpvn35"
      password     = "Ffjk8ckmpx@123"
      sku_name     = "B_Standard_B1ms"
      storage_size = 32768
      zone         = "1"
    }
    resource_group  = "rg1"
    virtual_network = "vnet1"
    subnet          = "postgres_subnet"
  }
}



network_security_groups = {
  "nsg1" = {
    name           = "network_security_group_1"
    resource_group = "rg1"
    rules = {
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
      }
    }
  }
}


vm_config = {
  "vm1" = {
    name           = "dotnet-vm"
    vnet           = "vnet1"
    subnet         = "subnet1"
    resource_group = "rg1"
    nic_name       = "dotnet-nic"
    nsg_name       = "nsg1"
    public_ip      = "ip1"
  }
}


public_ips = {
  "ip1" = {
    name           = "public-ip-for-dotnet"
    resource_group = "rg1"
  }
}