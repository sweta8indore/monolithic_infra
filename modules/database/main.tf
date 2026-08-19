resource "azurerm_mssql_server" "sql" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"

  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  public_network_access_enabled = false
 
}

resource "azurerm_mssql_database" "db" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.sql.id
  sku_name  = "S0"
  
}

# Private Endpoint
resource "azurerm_private_endpoint" "pe" {
  name                = "sql-pe"
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "sql-conn"
    private_connection_resource_id = azurerm_mssql_server.sql.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
}