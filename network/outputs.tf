output "resource_group" {
  description = "Useful information about the resource group."
  value = {
    id       = azurerm_resource_group.this.id
    name     = azurerm_resource_group.this.name
    location = azurerm_resource_group.this.location
  }
}

output "subnet_id" {
  description = "The default subnet ID."
  value       = azurerm_subnet.default.id
}
