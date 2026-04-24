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

#   backend "azurerm" {
#     resource_group_name  = "rg-key-vault-dev"
#     storage_account_name = "ststorageutlw93"
#     container_name       = "sc-tfstate-dev-utlw93"
#     key                  = "key-vault-dev"
#   }
}

provider "azurerm" {
  features {
  }
}
