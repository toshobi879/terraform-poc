locals {
  has_alarm_email = length(var.alarm_email) > 0
}

# KMS Key (optional)
resource "aws_kms_key" "kmskey" {
  count                = var.create_kms_key ? 1 : 0
  description          = "Org baseline CMK"
  enable_key_rotation  = true
}

resource "aws_kms_alias" "kms_alias" {
  count      = var.create_kms_key ? 1 : 0
  name       = var.key_alias
  target_key_id = aws_kms_key.kmskey[0].key_id
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "baseline_lg" {
  name              = var.log_group_name
  retention_in_days = var.log_retention_days
}

# SNS Topic (optional)
resource "aws_sns_topic" "alerts" {
  count = var.create_sns_topic ? 1 : 0
  name  = var.sns_topic_name

  kms_master_key_id = var.create_kms_key ? aws_kms_key.kmskey[0].arn : null
}

resource "aws_sns_topic_subscription" "alerts_sub" {
  count = var.create_sns_topic && local.has_alarm_email ? 1 : 0

  topic_arn = aws_sns_topic.alerts[0].arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

# BreakGlass IAM Role
resource "aws_iam_role" "break_glass" {
  name = var.break_glass_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { AWS = var.break_glass_principal_arns }
    }]
  })

  description          = "Emergency administrator role (time-bound use only)"
  max_session_duration = 3600

  tags = {
    Purpose = "BreakGlass"
  }
}

resource "aws_iam_role_policy_attachment" "break_glass_attach" {
  role       = aws_iam_role.break_glass.name
  policy_arn = var.break_glass_managed_policy_arn
}

# ReadOnly IAM Role
resource "aws_iam_role" "readonly" {
  name = var.readonly_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Principal = { AWS = var.readonly_principal_arns }
    }]
  })

  description          = "Read-only access role"
  max_session_duration = 3600

  tags = {
    AccessLevel = "ReadOnly"
  }
}

resource "aws_iam_role_policy_attachment" "readonly_attach" {
  role       = aws_iam_role.readonly.name
  policy_arn = var.readonly_policy_arn
}
