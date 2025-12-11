vpc_id = "vpc-06bc40fbf7fd648cd"
region = "us-west-2"

route_table_id = "rtb-048fcc45296182fd1"

subnet_ids_for_interface_endpoints = [
  "subnet-0aafb2646b47c986e",
  "subnet-09d8824b9c18a9382"
]

interface_endpoint_security_group_id = "sg-0a6365c6219148980"

create_s3_gateway_endpoint       = true
create_dynamodb_gateway_endpoint = true
create_ssm_interface_endpoints   = true

enable_flow_logs         = true
flow_logs_to             = "CWLogs"
flow_logs_log_group_name = "/vpc/flowlogs"
flow_logs_retention_days = 90

flow_logs_s3_bucket_arn = ""
