# -----------------------------------------------------------------------------
# Outputs
# Key values printed after terraform apply completes
# These are also queryable via: terraform output <name>
# -----------------------------------------------------------------------------

output "app_url" {
  description = "Live URL of the deployed web application"
  value       = "https://${azurerm_container_app.main.latest_revision_fqdn}"
}

output "resource_group" {
  description = "Resource group containing all project infrastructure"
  value       = azurerm_resource_group.main.name
}

output "log_analytics_workspace" {
  description = "Log Analytics workspace for container observability"
  value       = azurerm_log_analytics_workspace.main.name
}

output "container_app_environment" {
  description = "Container Apps environment hosting the workload"
  value       = azurerm_container_app_environment.main.name
}

output "container_image" {
  description = "Container image currently deployed"
  value       = "nginx:alpine"
}
