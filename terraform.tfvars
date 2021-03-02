# Resource group
location            = "East US"
resource_group_name = "rg-aks"

# AKS
default_pool_name          = "agentpool"
node_count                 = 1
vm_size                    = "Standard_D2_v2"
ssh_public_key             = "~/.ssh/id_rsa.pub"
dns_prefix                 = "aks"
cluster_name               = "aks"
max_pods                   = 30
min_count                  = 1
max_count                  = 5
default_pool_type          = "VirtualMachineScaleSets"
scale_down_delay_after_add = "2m"
scale_down_unneeded        = "2m"

# ACR
acr_name = "edtroleisacr"
acr_sku  = "Basic"

# Monitoring
log_analytics_workspace_name     = "aksLogAnalyticsWorkspaceName"
log_analytics_workspace_location = "eastus"
log_analytics_workspace_sku      = "PerGB2018"

# Tags
owner       = "Troleis"
project     = "azure-aks"
environment = "Development"