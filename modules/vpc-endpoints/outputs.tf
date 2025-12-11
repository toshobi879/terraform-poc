output "s3_gateway_endpoint_id" {
  value       = try(aws_vpc_endpoint.s3_gateway[0].id, null)
}

output "dynamodb_gateway_endpoint_id" {
  value       = try(aws_vpc_endpoint.dynamodb_gateway[0].id, null)
}

output "interface_endpoints" {
  value = {
    for name, ep in aws_vpc_endpoint.interface : name => ep.id
  }
}
