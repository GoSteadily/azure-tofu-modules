output "vm_public_ips" {
  description = "The public IP addresses of the virtual machines."
  value       = [for vm in module.vm : vm.ip_address]
}

output "vm_public_keys" {
  description = "The public key of the admin user for the virtual machine."
  value       = [for vm in module.vm : vm.public_key]
}

output "vm_private_keys" {
  description = "The private key of the admin user for the virtual machine."
  value       = [for vm in module.vm : vm.private_key]
  sensitive   = true
}

output "db_host" {
  description = "The FQDN of the database."
  value       = module.db.host
}

output "db_user" {
  description = "The name of the database administrator."
  value       = module.db.user
}

output "db_password" {
  description = "The password for the database administrator."
  value       = module.db.password
  sensitive   = true
}

output "db_name" {
  description = "The name of the database."
  value       = module.db.name
}
