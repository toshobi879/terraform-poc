module "baseline" {
  source = "../../../modules/baseline"

  break_glass_principal_arns = var.break_glass_principal_arns
  readonly_principal_arns    = var.readonly_principal_arns

  create_kms_key   = var.create_kms_key
  create_sns_topic = var.create_sns_topic
  alarm_email      = var.alarm_email
}
