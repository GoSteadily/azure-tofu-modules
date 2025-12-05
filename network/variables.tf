variable "name" {
  description = "The name of the application."
  type        = string
}

variable "location" {
  description = "The location for all the resources."
  type        = string
}

variable "addresses" {
  description = "The address space of the virtual network that must be given in CIDR notation."
  type        = string
}
