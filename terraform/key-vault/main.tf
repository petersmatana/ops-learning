resource "random_string" "suffix" {
  length    = 6
  lower     = true
  special   = false
  numeric   = true
  upper     = false
  min_upper = 0
}

resource "azurerm_resource_group" "main-rg" {
  name     = "rg-${var.application_name}-${var.environemnt_name}"
  location = var.primary_location
}

resource "azurerm_storage_account" "sample-storage" {
  name                     = "st${var.storage_account_name}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.main-rg.name
  location                 = azurerm_resource_group.main-rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "sc-${var.storage_container_name}-${random_string.suffix.result}-${var.environemnt_name}"
  storage_account_name  = azurerm_storage_account.sample-storage.name
  container_access_type = "private"
}

# this data source only looking at the current authentication context
# of Azure resources
data "azurerm_client_config" "client_conf" {}

resource "azurerm_key_vault" "key-vault" {
  name                = "kv-${var.application_name}-${random_string.suffix.result}-${var.environemnt_name}"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name
  tenant_id           = data.azurerm_client_config.client_conf.tenant_id
  sku_name            = "standard"
}

resource "azurerm_role_assignment" "terraform_user" {
  # who has access to what
  principal_id = data.azurerm_client_config.client_conf.object_id

  # buidin role definition which contain collection of permissions
  # that will be granted
  role_definition_name = "Key Vault Administrator"

  # TODO ?
  scope = azurerm_key_vault.key-vault.id
}
