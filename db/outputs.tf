output "id" {
  description = "The ID of the database server."
  value       = azurerm_postgresql_flexible_server.this.id
}

output "host" {
  description = "The FQDN of the database server."
  value       = azurerm_postgresql_flexible_server.this.fqdn
}

output "user" {
  description = "The username of the database server administrator."
  value       = azurerm_postgresql_flexible_server.this.administrator_login
}

output "password" {
  description = "The password for the database server administrator."
  value       = azurerm_postgresql_flexible_server.this.administrator_password
  sensitive   = true
}

output "name" {
  description = "The name of the database."
  value       = azurerm_postgresql_flexible_server_database.this.name
}
