## BCG - Azure Automation account variables should be encrypted ##
resource "azurerm_automation_variable_string" "Example-Jay" {
  name                    = "tfex-example-var2"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = true
  value                   = "This is Jay-Test"
}