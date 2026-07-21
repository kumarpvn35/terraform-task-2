variable "name" {
  type = string
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}
