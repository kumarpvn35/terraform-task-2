terraform {
  backend "azurerm" {
    key = "task.tfstate"
    storage_account_name = "tfstatefiles35"
    container_name = "terraform-statefile-container"
    resource_group_name = "terraform_statefile_rg"
  }
}