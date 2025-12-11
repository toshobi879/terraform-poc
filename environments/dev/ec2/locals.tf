locals {
  common_tags = {
    Application  = var.application
    Environment  = var.environment
    Owner        = var.owner
    SupportGroup = var.support_group
  }
}
