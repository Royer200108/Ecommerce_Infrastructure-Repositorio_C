resource "azurerm_linux_function_app" "serverless-app" {
  name                = "serverless-${ var.project }-${ var.environment }"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  storage_account_name       = azurerm_storage_account.saccount.name
  storage_account_access_key = azurerm_storage_account.saccount.primary_access_key
  service_plan_id            = azurerm_service_plan.sp.id

  site_config {
    always_on                 = true
  }
}