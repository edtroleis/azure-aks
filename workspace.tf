# data "azurerm_storage_account" "storage-account" {
#   name                = var.storage_account_diag_sett
#   resource_group_name = azurerm_resource_group.rg-aks.name
# }

# data "azurerm_kubernetes_cluster" "aks-data" {
#   name                = var.cluster_name
#   resource_group_name = azurerm_resource_group.rg-aks.name
#   depends_on = [azurerm_kubernetes_cluster.aks]
# }

# resource "azurerm_monitor_diagnostic_setting" "diagnostic-setting" {
#   name               = var.diag_sett_name
#   target_resource_id = data.azurerm_kubernetes_cluster.aks-data.id
#   storage_account_id = data.azurerm_storage_account.storage-account.id
#   depends_on = [azurerm_storage_account.storage-account]

#   # log {
#   #   category = "Audit"
#   #   enabled  = false

#   #   retention_policy {
#   #     enabled = false
#   #   }
#   # }

#   metric {
#     category = "AllMetrics"
#     enabled = true

#     retention_policy {
#       enabled = false
#     }
#   }
# }


# resource "azurerm_log_analytics_workspace" "log-analytics-workspace" {
#   name                = "acctest-01"
#   location            = azurerm_resource_group.rg-aks.location
#   resource_group_name = azurerm_resource_group.rg-aks.name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
# }

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "log-analytics-workspace" {
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
  name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location            = var.log_analytics_workspace_location
  resource_group_name = azurerm_resource_group.rg-aks.name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = 30
}

resource "azurerm_log_analytics_solution" "log-analytics-solution" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.log-analytics-workspace.location
  resource_group_name   = azurerm_resource_group.rg-aks.name
  workspace_resource_id = azurerm_log_analytics_workspace.log-analytics-workspace.id
  workspace_name        = azurerm_log_analytics_workspace.log-analytics-workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}
