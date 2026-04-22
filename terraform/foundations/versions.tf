terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.68.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.8.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-petersapp-dev"
    storage_account_name = "ststoragelfm0an"
    container_name       = "sc-tfstate-dev-lfm0an"
    key                  = "myapplication-dev"
  }
}

provider "azurerm" {
  features {
  }
}
