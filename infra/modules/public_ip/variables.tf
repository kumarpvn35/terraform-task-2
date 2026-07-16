variable "public_ip_name" {
  type = string
}

variable "resource_group" {
  description = "The name of the Azure resource group."
  type        = object({
    name = string,
    location = string
  })
}