backup_vault_name = "Daily-Backup-Vault"
region = "us-west-2"

backup_plan_name  = "Daily-Backup-Plan"

backup_role_name  = "daily-backup-service-role"

backup_rule = {
  rule_name         = "daily-backup-rule"
  schedule          = "cron(0 18 ? * * *)"  # 11:30 PM IST
  target_vault_name = "Daily-Backup-Vault"

  lifecycle = {
    delete_after = 7
  }
}
