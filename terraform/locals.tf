# -----------------------------------------------------------------------------
# Locals
# Computed values and tags built from variables
# common_tags applied to every resource for consistent ownership tracking
# -----------------------------------------------------------------------------

locals {
  common_tags = {
    project     = var.project_name
    owner       = var.owner
    environment = var.environment
    managed_by  = "terraform"
  }
}
