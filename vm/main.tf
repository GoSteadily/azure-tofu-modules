resource "azurerm_public_ip" "this" {
  name                = "${var.name}-ip"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "this" {
  name                = "${var.name}-nic"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  ip_configuration {
    name                          = "default"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

resource "tls_private_key" "this" {
  algorithm = "ED25519"
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = "${var.name}-vm"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location

  admin_username = var.admin_username

  size = var.vm_size

  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.this.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}
