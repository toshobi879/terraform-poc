###################################
# Backup Vault
###################################
resource "aws_backup_vault" "this" {
  name = var.backup_vault_name
}

###################################
# IAM Role for AWS Backup
###################################
resource "aws_iam_role" "backup_role" {
  name = var.backup_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "backup.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "backup_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "restore_policy" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

###################################
# Backup Plan
###################################
resource "aws_backup_plan" "this" {
  name = var.backup_plan_name

  rule {
    rule_name         = var.backup_rule.rule_name
    target_vault_name = var.backup_rule.target_vault_name
    schedule          = var.backup_rule.schedule

    lifecycle {
      delete_after = var.backup_rule.lifecycle.delete_after
    }
  }
}

###################################
# Backup Selection
###################################
resource "aws_backup_selection" "tag_selection" {
  name         = "tag-based-selection"
  iam_role_arn = aws_iam_role.backup_role.arn
  plan_id      = aws_backup_plan.this.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }
}
