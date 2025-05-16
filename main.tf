provider "azurerm" {
  features {}
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = module.network.subnet_id
}

terraform {
  backend "remote" {
    organization = "ACME_Corp_Org"

    workspaces {
      name = "terraform-azure-demo"
    }
  }
}
