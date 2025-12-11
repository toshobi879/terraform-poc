terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}
module "rds" {
  source = "../../../modules/rds"

  subnet_ids                      = var.rds_subnet_ids
  vpc_id                          = var.vpc_id
  db_engine                       = var.db_engine
  db_engine_version               = var.db_engine_version
  db_instance_class               = var.db_instance_class
  allocated_storage               = var.allocated_storage
  storage_type                    = var.storage_type
  multi_az                        = var.multi_az
  kms_key_id                      = var.kms_key_id
  master_username                 = var.master_username
  master_user_password            = var.master_user_password
  db_name                         = var.db_name
  backup_retention_days           = var.backup_retention_days
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  deletion_protection             = var.deletion_protection
  allowed_cidr                    = var.allowed_cidr_for_db_port
  allowed_security_group_id       = var.allowed_security_group_id
  enable_performance_insights     = var.enable_performance_insights
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  tags                            = local.common_tags
}
