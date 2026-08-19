terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.65.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-state"
    storage_account_name = "terraformstatefile55"
    container_name = "tfstate"
    key = "dev.terraform.state"
  }
}
provider "azurerm" {
    features {
           key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
    }
    subscription_id = "6caad0e1-3e31-4888-9ab4-f7a5829c9680"
  
}