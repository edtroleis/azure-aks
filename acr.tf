resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = azurerm_resource_group.rg-aks.name
  location                 = azurerm_resource_group.rg-aks.location
  sku                      = var.acr_sku
  admin_enabled            = false
}