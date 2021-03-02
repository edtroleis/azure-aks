
# Resource group
variable "resource_group_name" {
  description = "Aks resource group"
  type        = string
}

variable "location" {
  description = "Location where the resources will be created"
  type        = string
}

# AKS
variable "default_pool_name" {
  description = "Default pool name"
  type        = string
}
variable "node_count" {
  description = "Number of aks node"
  type        = number
}

variable "vm_size" {
  description = "Aks node pool size"
  type        = string
}

variable "ssh_public_key" {
  description = "ssh plublic key"
  type        = string
}

variable "dns_prefix" {
  description = "aks dns"
  type        = string
}

variable "cluster_name" {
  description = "Aks name"
  type        = string
}

variable "max_pods" {
  description = "Max number o pods"
  type        = number
}

variable "min_count" {
  description = "Minimum Node Count"
  type        = number
}
variable "max_count" {
  description = "Maximum Node Count"
  type        = number
}

variable "default_pool_type" {
  description = "type of the agent pool (AvailabilitySet and VirtualMachineScaleSets)"
}

variable "scale_down_delay_after_add" {
  description = "Aks autoscaling scale_down_delay_after_add"
  type        = string
}

variable "scale_down_unneeded" {
  description = "Aks autoscaling scale_down_unneeded"
  type        = string
}

# ACR
variable "acr_name" {
  description = "Acr name"
  type        = string
}

variable "acr_sku" {
  description = "Acr sku"
  type        = string
}

# Log Analytics
variable "log_analytics_workspace_name" {
  description = "log analytics workspace name"
  type        = string
}

variable "log_analytics_workspace_location" {
  description = "log analytics workspace location"
  type        = string
}

variable "log_analytics_workspace_sku" {
  description = "log analytis worksapce sku"
  type        = string
}

# Tags
variable "owner" {
  description = "Tag owner"
  type        = string
}

variable "project" {
  description = "Tag project"
  type        = string
}

variable "environment" {
  description = "Tag environment"
  type        = string
}
