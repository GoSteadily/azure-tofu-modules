output "ip_address" {
  description = "The public IP address of the virtual machine."
  value       = azurerm_linux_virtual_machine.this.public_ip_address
}

output "public_key" {
  description = "The public key of the admin user for the virtual machine."
  value       = tls_private_key.this.public_key_openssh
}

output "private_key" {
  description = "The private key of the admin user for the virtual machine."
  value       = tls_private_key.this.private_key_openssh
  sensitive   = true
}
