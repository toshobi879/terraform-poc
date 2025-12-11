variable "break_glass_role_name" {
  type    = string
  default = "BreakGlassRole"
}

variable "break_glass_managed_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "break_glass_principal_arns" {
  type = list(string)
}

variable "readonly_role_name" {
  type    = string
  default = "ReadOnlyRole"
}

variable "readonly_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "readonly_principal_arns" {
  type = list(string)
}

variable "create_kms_key" {
  type    = bool
  default = true
}

variable "key_alias" {
  type    = string
  default = "alias/org-default"
}

variable "log_group_name" {
  type    = string
  default = "/org/baseline"
}

variable "log_retention_days" {
  type    = number
  default = 90
}

variable "create_sns_topic" {
  type    = bool
  default = true
}

variable "sns_topic_name" {
  type    = string
  default = "org-alerts"
}

variable "alarm_email" {
  type    = string
  default = ""
}
