variable "config" {
  type = object({
    name         = string
    version      = string
    username     = string
    password     = string
    storage_size = number
    sku_name     = string
    zone         = string
  })
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}


variable "subnet_id" {
  type = string
}

variable "virtual_network_id" {
  type = string
}