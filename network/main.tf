resource "azurerm_resource_group" "this" {
  name     = "${var.name}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.name}-vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = [var.addresses]
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [cidrsubnet(var.addresses, 8, 0)]
}

resource "azurerm_network_security_group" "this" {
  name                = "${var.name}-nsg"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  security_rule {
    direction                  = "Inbound"
    priority                   = 100
    name                       = "SSH"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    protocol                   = "Tcp"
    access                     = "Allow"
  }

  security_rule {
    direction                  = "Inbound"
    priority                   = 120
    name                       = "HTTP"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "80"
    protocol                   = "Tcp"
    access                     = "Allow"
  }

  security_rule {
    direction                  = "Inbound"
    priority                   = 140
    name                       = "HTTPS"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "443"
    protocol                   = "Tcp"
    access                     = "Allow"
  }

  security_rule {
    direction                  = "Inbound"
    priority                   = 160
    name                       = "Mosh"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "60000-61000"
    protocol                   = "Udp"
    access                     = "Allow"
  }
}

resource "azurerm_subnet_network_security_group_association" "default" {
  #
  # N.B. Associating the network security group with the subnet is the recommended approach.
  #
  subnet_id                 = azurerm_subnet.default.id
  network_security_group_id = azurerm_network_security_group.this.id
}
