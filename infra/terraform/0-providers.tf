# terraform {
#   required_providers {
#     azurerm = {
#       source = "hashicorp/azurerm"
#       version = "3.91.0"
#     }
#   }
# }

# provider "azurerm" {
#   # Configuration options
#   features {}
# }

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.99.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    
  }
}