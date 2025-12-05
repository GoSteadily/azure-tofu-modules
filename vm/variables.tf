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

variable "subnet_id" {
  description = "The subnet ID."
  type        = string
}

variable "vm_size" {
  #
  # See https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/overview
  #
  # Sizes we've used in the past include:
  #
  # - Standard_DS1_v2
  # - Standard_D2s_v3
  #
  description = "The size of the virtual machine."
  type        = string
}


# Optional Inputs


variable "admin_username" {
  description = "The username for the administrator."
  type        = string
  default     = "azureuser"
}
