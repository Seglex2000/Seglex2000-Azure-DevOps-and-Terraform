terraform {
    backend "azurerm" {
        resource_group_name  = "tf_rg_tfstateblob"
        storage_account_name = "tfstatestorageblob"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
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
      image           = "seglex2000/weatherapi:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
              }
    }
}