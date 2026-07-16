variable "name" {
  type = string
}

variable "rules" {
  type = map(object({
    name                       = string
    protocol                   = string
    direction                  = string
    access                     = string
    priority                   = number
    source_port_range          = string
    source_address_prefix      = string
    destination_port_range     = string
    destination_address_prefix = string
  }))
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}
