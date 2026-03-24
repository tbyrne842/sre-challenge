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
# Centralised observability layer
# Retained from previous implementation — provides visibility into
# Static Web App requests and diagnostics
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
# Static Web App
# Selected over Container Apps for this use case because:
# - Genuinely free tier eligible unlike Container Apps solution
# - HTTPS enabled by default with no additional configuration
# - Built in GitHub Actions integration for CI/CD
# -----------------------------------------------------------------------------
resource "azurerm_static_web_app" "main" {
  name                = var.project_name
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  sku_tier            = "Free"
  sku_size            = "Free"
  tags                = local.common_tags
}
