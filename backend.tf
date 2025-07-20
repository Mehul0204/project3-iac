terraform {
  backend "azurerm" {
    resource_group_name  = "Project003_RG"
    storage_account_name = "project3tfg"
    container_name       = "pro-container"
    key                  = "terraform.tfstate"
  }
}
