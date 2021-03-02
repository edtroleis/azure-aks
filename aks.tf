resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg-aks.location
  resource_group_name = azurerm_resource_group.rg-aks.name
  dns_prefix          = var.dns_prefix

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name       = var.default_pool_name
    node_count = var.node_count
    vm_size    = var.vm_size
    # os_disk_size_gb = var.os_disk_size_gb
    # vnet_subnet_id  = var.vnet_subnet_id
    max_pods            = var.max_pods
    type                = var.default_pool_type
    enable_auto_scaling = true
    min_count           = var.min_count
    max_count           = var.max_count

    tags = merge(
      {
        "Owner" = var.owner
      },
      {
        "Project" = var.project
      },
      {
        "Environment" = var.environment
      },
    )
  }

  auto_scaler_profile {
    scale_down_delay_after_add = var.scale_down_delay_after_add
    scale_down_unneeded        = var.scale_down_unneeded
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.log-analytics-workspace.id
    }
    kube_dashboard {
      enabled = true
    }
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    "Owner"       = var.owner
    "Project"     = var.project
    "Environment" = var.environment
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic-setting" {
  name                       = "${azurerm_kubernetes_cluster.aks.name}-audit"
  target_resource_id         = azurerm_kubernetes_cluster.aks.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log-analytics-workspace.id
  log {
    category = "kube-apiserver"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "kube-controller-manager"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "cluster-autoscaler"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "kube-scheduler"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
  log {
    category = "kube-audit"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_role_assignment" "aks_to_acr_role" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  # skip_service_principal_aad_check = true
}

