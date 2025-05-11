terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=3.3.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.26.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
