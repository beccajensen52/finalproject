variable ARM_CLIENT_ID {}
variable ARM_CLIENT_SECRET {}
variable DJANGO_SECRET_KEY_PROD {}

terraform {
	required_providers {
		azurerm = {
			source = "hashicorp/azurerm"
			version = "4.68.0"
		}
	}

	backend "azurerm" {
		resource_group_nam = "rg-acmp-final"
		storage_account_name = "acmp2400storageaccount"
		container_name = "big-tf-state-acmp2400"
		key = "rebeccajensen"
		use_azuread_auth = true
	}
}

provider "azurerm" {
	features {}
}

resource "azurerm_container_registry" "rebeccajensen-acr" {
	name = "acrrebeccajensenacmp2400"
	resource_group_name = "rg-rebeccajensen"
	location = "Central US"
	sku = "Basic"
	admin_enabled = false
}

#new
resource "azurerm_container_group" "aci-rebeccajensen-acmp" {
	name = "aci-rebeccajensen-acmp"
	location = "Central US"
	resouce_group_name = "rg-rebeccajensen"
	ip_address_type = "Public"
	dns_name_label = "aci-rebeccajensen-acmp"
	os_type = "Linux"
	
	container {
		name = "final-app"
		image = "mcr.microsoft.com/azuredocs/final:latest"
		cpu = "0.5"
		memory = "1.5"

		ports {
			port = 8000
			protocol = "TCP"
		}
		secure_enviornment_variables {
			DJANGO_SECRET_KEY = var.DJANGO_SECRET_KEY_PROD
		}
	}
	
	image_registry_credential {
		server = "acrrebeccajensen2400.azurecr.io"
		username = var.ARM_CLIENT_ID
		password = var.ARM_CLIENT_SECRET
	}
}
