terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.101.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "prisma-build-test"
  location = "eastus"
}

## BCG - Azure Automation account variables should be encrypted ##

resource "azurerm_automation_account" "example" {
  name                = "build-test-automation-account"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "Basic"
  tags = {
    environment = "development"
  }
}

resource "azurerm_automation_variable_string" "example1" {
  name                    = "tfex-example-var1"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  value                   = "Hello, Terraform Basic Test1."
}

resource "azurerm_automation_variable_string" "example2" {
  name                    = "tfex-example-var2"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = false
  value                   = "Hello, Terraform Basic Test2."
}

resource "azurerm_automation_variable_string" "example3" {
  name                    = "tfex-example-var2"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = true
  value                   = "Hello, Terraform Basic Test3."
}

resource "azurerm_automation_variable_bool" "example1" {
  name                    = "tfex-example-var1"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  value                   = false
}

resource "azurerm_automation_variable_bool" "example2" {
  name                    = "tfex-example-var2"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = false
  value                   = false
}

resource "azurerm_automation_variable_bool" "example3" {
  name                    = "tfex-example-var3"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = true
  value                   = false
}

resource "azurerm_automation_variable_datetime" "example1" {
  name                    = "tfex-example-var1"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  value                   = "2019-04-24T21:40:54.074Z"
}

resource "azurerm_automation_variable_datetime" "example2" {
  name                    = "tfex-example-var2"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = false 
  value                   = "2019-04-24T21:40:54.074Z"
}

resource "azurerm_automation_variable_datetime" "example3" {
  name                    = "tfex-example-var3"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = true
  value                   = "2019-04-24T21:40:54.074Z"
}

resource "azurerm_automation_variable_int" "example1" {
  name                    = "tfex-example-var1"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  value                   = 1234
}

resource "azurerm_automation_variable_int" "example2" {
  name                    = "tfex-example-var2"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = false
  value                   = 1234
}

resource "azurerm_automation_variable_int" "example3" {
  name                    = "tfex-example-var3"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = true
  value                   = 1234
}

resource "azurerm_automation_variable_object" "example1" {
  name                    = "tfex-example-var1"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  value = jsonencode({
    greeting = "Hello, Terraform Basic Test."
    language = "en"
  })
}

resource "azurerm_automation_variable_object" "example2" {
  name                    = "tfex-example-var2"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = false 
  value = jsonencode({
    greeting = "Hello, Terraform Basic Test."
    language = "en"
  })
}

resource "azurerm_automation_variable_object" "example3" {
  name                    = "tfex-example-var3"
  resource_group_name     = azurerm_resource_group.example.name
  automation_account_name = azurerm_automation_account.example.name
  encrypted               = true
  value = jsonencode({
    greeting = "Hello, Terraform Basic Test."
    language = "en"
  })
}

## BCG - Azure Audit provisioning of an Azure Active Directory administrator for SQL server ##

resource "azurerm_mssql_server" "example" {
  name                         = "mssqlserver"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11"
  minimum_tls_version          = "1.2"

  tags = {
    environment = "production"
  }
}

## BCG - Azure Function App should only be accessible over HTTPS - Enforcement Available ##

resource "azurerm_linux_function_app" "example" {
  name                = "example-linux-function-app"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  service_plan_id     = azurerm_service_plan.example.id

  site_config {}
}

resource "azurerm_windows_function_app" "example" {
  name                = "example-windows-function-app"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  service_plan_id     = azurerm_service_plan.example.id

  site_config {}
}

## BCG - Azure LB publicly accessible with open ports 22 or 3389 ##

resource "azurerm_lb" "example" {
  name                = "TestLoadBalancer"
  location            = "West US"
  resource_group_name = azurerm_resource_group.example.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.example.id
  name                           = "LBRuleSSH"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.example.id
  name                           = "LBRuleRDP"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress"
}

## BCG - Azure Secure transfer to storage accounts should be enabled - Enforcement Available

