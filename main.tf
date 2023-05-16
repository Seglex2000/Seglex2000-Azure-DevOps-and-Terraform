terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_api" {
  name = "tfapirg"
  location = "West Europe"
}

resource "azurerm_container_group" "tfcg_api" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_api.location
  resource_group_name       = azurerm_resource_group.tf_api.name

  ip_address_type = "Public"
  dns_name_label         = "seglex2000wa"
  os_type                   = "Linux"


    container {
      name            = "weatherapi"
      image           = "seglex2000/weatherapi"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
              }
    }
}