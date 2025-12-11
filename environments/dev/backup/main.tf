module "backup" {
  source = "../../../modules/backup"

  backup_vault_name = var.backup_vault_name
  backup_plan_name  = var.backup_plan_name
  backup_role_name  = var.backup_role_name

  backup_rule = var.backup_rule
}
