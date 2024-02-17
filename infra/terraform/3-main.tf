# resource "azurerm_resource_group" "name" {
#   location = 
# }

data "azurerm_resource_group" "odl_rg" {
  name = local.odl_rg_name
}

# resource "azurerm_resource_group" "myrg" {
#   location = local.location
#   name = "ahmedavid_rg"
# }

output "odl_rg" {
  value = data.azurerm_resource_group.odl_rg
}