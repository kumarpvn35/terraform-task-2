resource "azurerm_network_interface" "nic" {
  name = var.nic_name
  resource_group_name = var.resource_group.name
  location = var.resource_group.location
    ip_configuration {
        name                          = "testconfiguration1"
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = var.public_ip_id
    }   
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_security_group_id = var.nsg_id
  network_interface_id = azurerm_network_interface.nic.id
}


resource "azurerm_linux_virtual_machine" "vm-2" {
  name                = var.vm_name
  resource_group_name  = var.resource_group.name
  location = var.resource_group.location
  size                = "Standard_D2s_v3"
  admin_username      = "azureuser"
    network_interface_ids = [azurerm_network_interface.nic.id]

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.public_key_value
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  custom_data = filebase64("${path.module}/../../cloud-init.yml")
}