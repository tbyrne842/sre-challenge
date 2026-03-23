# -----------------------------------------------------------------------------
# Variables
# Declares all inputs the infrastructure accepts
# Override defaults by modifying terraform.tfvars
# -----------------------------------------------------------------------------

variable "project_name" {
  description = "Name used across all resources"
  type        = string
  default     = "sre-challenge"
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "UK South"
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "Tiarnan Byrne"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "log_retention_days" {
  description = "Number of days to retain logs in Log Analytics"
  type        = number
  default     = 30
}

variable "container_cpu" {
  description = "CPU allocation for the container app"
  type        = number
  default     = 0.25
}

variable "container_memory" {
  description = "Memory allocation for the container app"
  type        = string
  default     = "0.5Gi"
}
