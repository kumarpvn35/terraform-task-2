variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "nic_name" {
  description = "value of the network security group name."
    type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
}

variable "resource_group" {
  description = "The name of the Azure resource group."
  type        = object({
    name = string,
    location = string
  })
}

variable "nsg_id" {
  type = string
}

variable "public_key_value" {
  type = string
}

variable "public_ip_id" {
  type = string
}