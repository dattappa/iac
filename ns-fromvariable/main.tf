provider "azurerm" {
  features {}
}

# provider "kubernetes" {
#     load_config_file = false
# }

provider "kubernetes" {
  config_path = "~/.kube/config"  
}