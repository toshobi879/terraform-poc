output "break_glass_role_arn" {
  value = aws_iam_role.break_glass.arn
}

output "readonly_role_arn" {
  value = aws_iam_role.readonly.arn
}

output "kms_key_arn" {
  value = var.create_kms_key ? aws_kms_key.kmskey[0].arn : null
}

output "alerts_topic_arn" {
  value = var.create_sns_topic ? aws_sns_topic.alerts[0].arn : null
}
