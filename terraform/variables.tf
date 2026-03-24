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
# Regions available for static web app 'westus2,centralus,eastus2,westeurope,eastasia'
variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "West Europe"
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
