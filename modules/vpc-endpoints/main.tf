##########################################
# Gateway Endpoints (S3, DynamoDB)
##########################################

resource "aws_vpc_endpoint" "s3_gateway" {
  count = var.create_s3_gateway_endpoint ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.route_table_id]
}

resource "aws_vpc_endpoint" "dynamodb_gateway" {
  count = var.create_dynamodb_gateway_endpoint ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.route_table_id]
}

##########################################
# Interface Endpoints (SSM + related)
##########################################

locals {
  interface_endpoints = var.create_ssm_interface_endpoints ? {
    ssm          = "ssm"
    ssmmessages  = "ssmmessages"
    ec2messages  = "ec2messages"
  } : {}
}

resource "aws_vpc_endpoint" "interface" {
  for_each = local.interface_endpoints

  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids_for_interface_endpoints
  security_group_ids  = [var.interface_endpoint_security_group_id]
  private_dns_enabled = true
}

##########################################
# CloudWatch Flow Logs
##########################################

resource "aws_cloudwatch_log_group" "flow_logs" {
  count = var.enable_flow_logs && var.flow_logs_to == "CWLogs" ? 1 : 0

  name              = var.flow_logs_log_group_name
  retention_in_days = var.flow_logs_retention_days
}

resource "aws_iam_role" "flow_logs_role" {
  count = var.enable_flow_logs && var.flow_logs_to == "CWLogs" ? 1 : 0

  name = "${var.vpc_id}-flowlogs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "vpc-flow-logs.amazonaws.com" }
      Action   = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "flow_logs_role_policy" {
  count = var.enable_flow_logs && var.flow_logs_to == "CWLogs" ? 1 : 0

  role = aws_iam_role.flow_logs_role[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = aws_cloudwatch_log_group.flow_logs[0].arn
    }]
  })
}

resource "aws_flow_log" "flow_logs_cw" {
  count = var.enable_flow_logs && var.flow_logs_to == "CWLogs" ? 1 : 0

  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.flow_logs[0].arn
  iam_role_arn         = aws_iam_role.flow_logs_role[0].arn

  traffic_type = "ALL"
  vpc_id       = var.vpc_id
}

##########################################
# S3 Flow Logs
##########################################

resource "aws_flow_log" "flow_logs_s3" {
  count = var.enable_flow_logs && var.flow_logs_to == "S3" ? 1 : 0

  log_destination      = var.flow_logs_s3_bucket_arn
  log_destination_type = "s3"

  traffic_type = "ALL"
  vpc_id       = var.vpc_id
}
