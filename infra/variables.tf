variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
}


variable "virtual_networks" {
  type = map(object({
    name           = string
    address_space  = list(string)
    resource_group = string
    subnets = optional(map(object({
      name           = string
      address_prefix = list(string)
      delication_config = optional(object({
        name = string
        details = object({
          name    = string
          actions = list(string)
        })
      }))
    })), {})
  }))
}



variable "database" {
  type = map(object({
    config = object({
      name         = string
      version      = string
      username     = string
      password     = string
      storage_size = number
      sku_name     = string
      zone         = string
    })
    resource_group  = string
    virtual_network = string
    subnet          = string
  }))
}


variable "key_vault_name" {
  type = string
}


variable "key_vault_rg" {
  type = string
}


variable "network_security_groups" {
  type = map(object({
    name           = string
    resource_group = string
    rules = optional(map(object({
      name                       = string
      protocol                   = string # Tcp, Udp, Icmp, Esp, Ah, *(All)
      direction                  = string # Inbound, Outbound
      priority                   = number # 100 - 4096
      access                     = string # Allow, Deny
      source_port_range          = string # 0 - 65535 or *
      source_address_prefix      = string # CIDR or source IP range or * to match any IP
      destination_port_range     = string # 0 - 65535 or *
      destination_address_prefix = string # CIDR or source IP range or * to match any IP
    })), {})
  }))
}


variable "vm_config" {
  type = map(object({
    name           = string
    vnet           = string
    subnet         = string
    resource_group = string
    nic_name       = string
    nsg_name       = string
    public_ip      = string
  }))
}


variable "public_ips" {
  type = map(object({
    name           = string
    resource_group = string
  }))
}