#
# Required
#

variable "name" {
  description = "The name of the application."
  type        = string
}

variable "vm_size" {
  #
  # See https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/overview
  #
  # - The Av2-series sizes are good for development and test servers
  #   Learn more: https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/av2-series?tabs=sizebasic
  #
  #   Standard_A1_v2
  #   Standard_A2_v2
  #
  # - The Dsv4-series sizes are good for enterprise-grade applications
  #   Learn more: https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dsv4-series?tabs=sizebasic
  #
  #   Standard_D2s_v4
  #   Standard_D4s_v4
  #
  description = "The size of the virtual machine."
  type        = string
}

variable "db_admin_username" {
  description = "The username of the database administrator."
  type        = string
}

variable "db_name" {
  description = "The name of the database."
  type        = string
}

variable "firewall_rules" {
  description = "The IP addresses that are allowed to connect to the database server."
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
}


#
# Optional
#

variable "group_to_location" {
  description = "A map of groups to locations."
  type        = map(string)
  default     = {}
}

variable "allowed_environments" {
  description = "The possible environments."
  type        = set(string)
  default     = ["dev", "staging", "prod"]
}

variable "addresses" {
  description = "The address space of the virtual network that must be given in CIDR notation."
  type        = string
  default     = "10.0.0.0/16"
}

variable "extra_pgbouncer_config" {
  description = "Extra configuration to set for PgBouncer in a production environment."
  type        = map(string)
  default     = {}
}
