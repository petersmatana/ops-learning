resource "random_string" "suffix" {
  length = 6
  lower = true
  special = false
  numeric = true
  upper = false
  min_upper = 0
}

resource "azurerm_resource_group" "main-rg" {
  name     = "rg-${var.application_name}-${var.environemnt_name}"
  location = var.primary_location
}

resource "azurerm_storage_account" "sample-storage" {
  name                     = "st${var.storage_name}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.main-rg.name
  location                 = azurerm_resource_group.main-rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
