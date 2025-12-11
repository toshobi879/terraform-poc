module "vpc_endpoints" {
  source = "../../../modules/vpc-endpoints"

  vpc_id                                   = var.vpc_id
  route_table_id                           = var.route_table_id
  subnet_ids_for_interface_endpoints       = var.subnet_ids_for_interface_endpoints
  interface_endpoint_security_group_id     = var.interface_endpoint_security_group_id

  create_s3_gateway_endpoint               = var.create_s3_gateway_endpoint
  create_dynamodb_gateway_endpoint         = var.create_dynamodb_gateway_endpoint
  create_ssm_interface_endpoints           = var.create_ssm_interface_endpoints

  enable_flow_logs                         = var.enable_flow_logs
  flow_logs_to                             = var.flow_logs_to
  flow_logs_log_group_name                 = var.flow_logs_log_group_name
  flow_logs_retention_days                 = var.flow_logs_retention_days
  flow_logs_s3_bucket_arn                  = var.flow_logs_s3_bucket_arn

  region = var.region
}
