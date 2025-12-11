variable "vpc_id" {
  type = string
}

variable "route_table_id" {
  type = string
}

variable "subnet_ids_for_interface_endpoints" {
  type = list(string)
}

variable "interface_endpoint_security_group_id" {
  type = string
}

variable "region" {
  type = string
}

variable "create_s3_gateway_endpoint" {
  type    = bool
  default = true
}

variable "create_dynamodb_gateway_endpoint" {
  type    = bool
  default = true
}

variable "create_ssm_interface_endpoints" {
  type    = bool
  default = true
}

variable "enable_flow_logs" {
  type    = bool
  default = true
}

variable "flow_logs_to" {
  type    = string
  default = "CWLogs"
}

variable "flow_logs_log_group_name" {
  type    = string
  default = "/vpc/flowlogs"
}

variable "flow_logs_retention_days" {
  type    = number
  default = 90
}

variable "flow_logs_s3_bucket_arn" {
  type    = string
  default = ""
}
