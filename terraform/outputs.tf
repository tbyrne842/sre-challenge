# -----------------------------------------------------------------------------
# Outputs
# Key values printed after terraform apply completes
# These are also queryable via: terraform output <name>
# -----------------------------------------------------------------------------

output "app_url" {
  description = "Live URL of the deployed web application"
  value       = "https://${azurerm_static_web_app.main.default_host_name}"
}

output "resource_group" {
  description = "Resource group containing all project infrastructure"
  value       = azurerm_resource_group.main.name
}

output "log_analytics_workspace" {
  description = "Log Analytics workspace for container observability"
  value       = azurerm_log_analytics_workspace.main.name
}
