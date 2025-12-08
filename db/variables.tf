variable "name" {
  description = "The name of the application."
  type        = string
}

variable "resource_group" {
  description = "The resource group."
  type = object({
    name     = string
    location = string
  })
}

variable "admin_username" {
  description = "The username of the database server administrator."
  type        = string
}

variable "db_name" {
  description = "The name of the database."
  type        = string
}


# Optional Inputs


variable "allow_azure_to_choose_zone" {
  description = "Whether or not to allow Azure to choose the availability zone for the database server."
  type        = bool
  default     = false
}

variable "zone" {
  description = "The availability zone to use for the database server."
  type        = number
  default     = 1
}

variable "backup_retention_days" {
  description = "The backup retention days for the database server."
  type        = number
  default     = 7
}

variable "firewall_rules" {
  description = "The IP addresses that are allowed to connect to the database server."
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default = {}
}

variable "server_version" {
  description = "The version of the database server."
  type        = string
  default     = "16"
}


#
# See https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute
#
variable "use_general" {
  description = "Determines which pricing tier to use between Burstable or General Purpose."
  type        = bool
  default     = false
}

variable "general_sku_name" {
  description = "A General Purpose SKU name to use for the pricing tier."
  type        = string
  default     = "GP_Standard_D2s_v3"
}

variable "burstable_sku_name" {
  description = "A Burstable SKU name to use for the pricing tier."
  type        = string
  default     = "B_Standard_B1ms"
}


variable "use_pgbouncer" {
  description = "Determines whether or not to use PGBouncer."
  type        = bool
  default     = false
}

variable "pgbouncer_default_pool_size" {
  description = "PgBouncer's default pool size."
  type        = number
  default     = 45
}
