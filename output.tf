output "host" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "azurerm_kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}
output "azurerm_kubernetes_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.aks.fqdn
}
output "azurerm_kubernetes_cluster_node_resource_group" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

# output "client_key" {
#     value = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
# }

# output "client_certificate" {
#     value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
# }

# output "cluster_ca_certificate" {
#     value = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
# }

# output "cluster_username" {
#     value = azurerm_kubernetes_cluster.aks.kube_config.0.username
# }

# output "cluster_password" {
#     value = azurerm_kubernetes_cluster.aks.kube_config.0.password
# }

# output "kube_config" {
#     value = azurerm_kubernetes_cluster.aks.kube_config_raw
# }
