variable "backup_vault_name" {
  description = "Name of the Backup Vault"
  type        = string
}

variable "backup_plan_name" {
  description = "Name of the Backup Plan"
  type        = string
}

variable "backup_role_name" {
  description = "Name of IAM role used by AWS Backup"
  type        = string
}

variable "backup_rule" {
  description = "Backup rule settings"
  type = object({
    rule_name         = string
    schedule          = string
    target_vault_name = string
    lifecycle = object({
      delete_after = number
    })
  })
}
