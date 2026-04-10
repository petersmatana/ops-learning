# resource "random_string" "suffix" {
#   length = 13
# }

# https://github.com/alfonsof/terraform-azure-examples/tree/master/code
terraform {
  # required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.67.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id                 = var.azure_subscription_id
  resource_provider_registrations = "none"
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "my_resource_group" {
  name     = "my_example_resources"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "my_virtual_network" {
  name                = "my_example_network"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  location            = azurerm_resource_group.my_resource_group.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "my_vistual_subnet" {
  name                 = "my_example_subnet"
  resource_group_name  = azurerm_resource_group.my_resource_group.name
  virtual_network_name = azurerm_virtual_network.my_virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "my_network_interface" {
  name                = "my_network_interface"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name

  ip_configuration {
    name                          = "my_network_nic"
    subnet_id                     = azurerm_subnet.my_vistual_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "my_linux_virtual_machine" {
  name                            = "my-linux-virtual-machine"
  location                        = azurerm_resource_group.my_resource_group.location
  resource_group_name             = azurerm_resource_group.my_resource_group.name
  size                            = "Standard_D2s_v3" # 2core, 8gb ram
  network_interface_ids           = [azurerm_network_interface.my_network_interface.id]
  admin_username                  = "doom-admin"
  admin_password                  = "Pass123!"
  disable_password_authentication = false

  #   admin_ssh_key {
  #     username   = "adminuser"
  #     public_key = file("~/.ssh/id_rsa.pub")
  #   }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    name                 = "my_linux_hdd"
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}
