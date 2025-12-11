terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.55.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.1.0"
    }
  }

  backend "azurerm" {
    #
    # You can get the missing values from `tofu -chdir=storage output`.
    #
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
