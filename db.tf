resource "azurerm_mssql_server" "sqlserver" {

    name = "dbserver-${ var.project }-${ var.environment }"
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    version = "12.0"
    administrator_login = "sqladmin"
    administrator_login_password = var.admin_sql_password

    tags = var.tags

}

resource "azurerm_mssql_database" "db" {
    name = "${ var.project }db"
    server_id = azurerm_mssql_server.sqlserver.id
    sku_name = "S0"
    tags = var.tags
}

resource "azurerm_redis_cache" "db-cache" {
  name                 = "db-redis-${var.project}-${ var.environment }"
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  capacity             = 1
  family               = "C"
  sku_name             = "Basic"
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"

  redis_configuration {
  }

  tags = var.tags
}