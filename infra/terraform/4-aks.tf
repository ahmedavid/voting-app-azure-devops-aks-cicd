data "azurerm_kubernetes_service_versions" "current" {
  location = local.location
  include_preview = false
}

# resource "azurerm_log_analytics_workspace" "insights" {
#   name = "logs-ahmedavid-insights"
#   location = azurerm_resource_group.myrg.location
#   resource_group_name = azurerm_resource_group.myrg.name
#   retention_in_days = 30
# }

# resource "azuread_group" "ask_administrators" {
#   display_name = "cluster administrators"
#   description = "AKS Administrators Group"
# }

resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name = "demo-aks"
  location = data.azurerm_resource_group.odl_rg.location
  resource_group_name = data.azurerm_resource_group.odl_rg.name
  dns_prefix = "exampleaks1"
  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    name = "systempool"
    os_sku = "Ubuntu"
    
    node_count = 2
    vm_size = "Standard_B2s"
    enable_auto_scaling = false
    # orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    # zones = [1,2]
    os_disk_size_gb = 30
    type = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type" = "system"
      "environment" = "dev"
    }
  }
  

  identity {
    type = "SystemAssigned"
  }

  # oms_agent {
  #   enabled = false
  # }

  role_based_access_control_enabled = false
  # azure_active_directory_role_based_access_control {
  #   managed = true
  #   admin_group_object_ids = []
  # }

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file("./ssh-keys/mykey.pub")
    }
  }

  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
    load_balancer_sku = "standard"
  }

  sku_tier = "Free"

  

  # azure_active_directory_role_based_access_control {
  #   managed = false
  #   azure_rbac_enabled = false
  # }



  # oms_agent {
    
  # }

  addon_profile {
    oms_agent {
      enabled = false      
    }
  }

  tags = {
    "Environment" = "dev"
  }
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks-cluster.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks-cluster.name
}

output "aks_cluster_kubernetes_version" {
  value = azurerm_kubernetes_cluster.aks-cluster.kubernetes_version
}
