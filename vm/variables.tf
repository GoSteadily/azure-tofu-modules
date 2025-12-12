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


# Optional Inputs


variable "admin_username" {
  description = "The username for the administrator."
  type        = string
  default     = "azureuser"
}

variable "os_disk_storage_account_type" {
  description = "The storage account type to use for the OS disk."
  type        = string
  default     = "Premium_LRS"
}
