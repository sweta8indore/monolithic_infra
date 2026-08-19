module "rg" {
  source = "../../modules/resource_group"

  rg_name  = var.rg_name
  location = var.location
}

module "network" {
  source        = "../../modules/network"
  vnet_name     = var.vnet_name
  address_space = var.address_space
  subnets  = var.subnets

  location      = var.location
  rg_name       = module.rg.rg_name
}

module "compute" {
  source = "../../modules/compute"
  rg_name  = module.rg.rg_name
  location = var.location
  vms        = var.vms
  subnets    = module.network.subnet_ids
  vm_username = data.azurerm_key_vault_secret.vm_username.value
  vm_password = data.azurerm_key_vault_secret.vm_password.value
}
module "database" {
  source = "../../modules/database"

  sql_server_name = "monolithic-db-334"
  sql_db_name     = "mydb"

  admin_username = data.azurerm_key_vault_secret.db_user.value
  admin_password = data.azurerm_key_vault_secret.db_pass.value

  subnet_id = module.network.subnet_ids["backend"]
  vnet_id   = module.network.vnet_id

  location = var.location
  rg_name  = var.rg_name
 
}



