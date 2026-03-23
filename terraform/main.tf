terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -----------------------------------------------------------------------------
# Resource Group
# Single container for all project resources
# -----------------------------------------------------------------------------
resource "azurerm_resource_group" "main" {
  name     = "${var.project_name}-rg"
  location = var.location
  tags     = local.common_tags
}

# -----------------------------------------------------------------------------
# Log Analytics Workspace
# Centralised observability layer for container logs and metrics
# Retention set to 30 days — appropriate for dev environment
# -----------------------------------------------------------------------------
resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.project_name}-logs"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days
  tags                = local.common_tags
}

# -----------------------------------------------------------------------------
# Container Apps Environment
# Shared infrastructure layer — equivalent to a Kubernetes namespace
# Explicitly linked to Log Analytics so container logs flow automatically
# -----------------------------------------------------------------------------
resource "azurerm_container_app_environment" "main" {
  name                       = "${var.project_name}-env"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  tags                       = local.common_tags
}

# -----------------------------------------------------------------------------
# Container App
# Nginx alpine chosen for minimal attack surface and lightweight footprint
# HTTPS termination handled at ingress layer — no certificate management needed
# CPU and memory set to minimum — appropriate for a static web workload
# Revision mode Single — one active deployment at a time
# -----------------------------------------------------------------------------
resource "azurerm_container_app" "main" {
  name                         = var.project_name
  container_app_environment_id = azurerm_container_app_environment.main.id
  resource_group_name          = azurerm_resource_group.main.name
  revision_mode                = "Single"
  tags                         = local.common_tags

  template {
    container {
      name   = "nginx"
      image  = "nginx:alpine"
      cpu    = var.container_cpu
      memory = var.container_memory
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80
    transport        = "http"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
