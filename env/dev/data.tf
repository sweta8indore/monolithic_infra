# 1. Existing Key Vault ka data fetch karna
data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.kv_rg_name
}

# 2. Username Secret fetch karna
data "azurerm_key_vault_secret" "vm_username" {
  name         = var.secret_username_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

# 3. Password Secret fetch karna
data "azurerm_key_vault_secret" "vm_password" {
  name         = var.secret_password_name
  key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "db_user" {
  name         = var.db_user_secret
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "db_pass" {
  name         = var.db_pass_secret
  key_vault_id = data.azurerm_key_vault.kv.id
}
