variable "break_glass_principal_arns" {
  type = list(string)
}

variable "readonly_principal_arns" {
  type = list(string)
}

variable "create_kms_key" {
  type = bool
}

variable "create_sns_topic" {
  type = bool
}

variable "alarm_email" {
  type = string
}
variable "region" {
  type = string
  
}