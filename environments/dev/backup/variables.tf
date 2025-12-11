variable "backup_vault_name" {
  type = string
}

variable "backup_plan_name" {
  type = string
}

variable "backup_role_name" {
  type = string
}
variable "region" {
    type = string
}

variable "backup_rule" {
  type = object({
    rule_name         = string
    schedule          = string
    target_vault_name = string
    lifecycle = object({
      delete_after = number
    })
  })
}
