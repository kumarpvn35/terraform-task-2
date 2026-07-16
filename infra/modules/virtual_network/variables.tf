variable "vnet_config" {
  type = object({
    name          = string
    address_space = list(string)
    resource_group = object({
      name     = string
      location = string
    })
  })
}

variable "subnet_config" {
  type = map(object({
    name           = string
    address_prefix = list(string)
    delication_config = optional(object({
      name = string
      details = object({
        name    = string
        actions = list(string)
      })
    }))
  }))
}
