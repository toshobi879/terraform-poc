variable "vpc_id" {}
variable "route_table_id" {}
variable "subnet_ids_for_interface_endpoints" {
  type = list(string)
}
variable "interface_endpoint_security_group_id" {}

variable "create_s3_gateway_endpoint" {}
variable "create_dynamodb_gateway_endpoint" {}
variable "create_ssm_interface_endpoints" {}
variable "enable_flow_logs" {}
variable "flow_logs_to" {}
variable "flow_logs_log_group_name" {}
variable "flow_logs_retention_days" {}
variable "flow_logs_s3_bucket_arn" {}
variable "region" {
  type    = string
}

