provider "azurerm" {
  features {}
}

module "rg" {
  source   = "../../modules/resource-group"
  name     = "dev-aks-rg"
  location = "East US"
}

module "network" {
  source    = "../../modules/network"
  vnet_name = "dev-vnet"
  location  = "East US"
  rg_name   = module.rg.name
}

module "acr" {
  source   = "../../modules/acr"
  name     = "devaksacr12345"
  location = "East US"
  rg_name  = module.rg.name
}

module "aks" {
  source    = "../../modules/aks"
  name      = "dev-aks"
  location  = "East US"
  rg_name   = module.rg.name
  subnet_id = module.network.subnet_id
}
