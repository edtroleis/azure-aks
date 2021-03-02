resource "azurerm_resource_group" "rg-aks" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    "Owner"       = var.owner
    "Project"     = var.project
    "Environment" = var.environment
  }
}



