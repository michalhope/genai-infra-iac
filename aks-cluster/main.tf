provider "azurerm" {
  features {}
}

locals {
  name = "ai-tinkerers-tlv"
  cluster_name = "${local.name}-aks"
  resource_group_name = "${local.name}-rg"
  location = "East US"
  node_count = 1
  vm_size = "Standard_DS2_v2"
  env = "dev"
}

resource "azurerm_resource_group" "aks_rg" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = local.cluster_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = local.cluster_name

  default_node_pool {
    name       = "default"
    node_count = local.node_count
    vm_size    = local.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = local.env
  }
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}
