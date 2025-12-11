variable "vpc_id" {}
variable "subnet_id" {}
variable "instance_type" {}
variable "ami_id" { default = "" }
variable "key_name" {}
variable "volume_size_gib" { }
variable "volume_type" { default = "gp3" }
variable "allow_ssh_cidr" { default = "0.0.0.0/0" }
variable "disable_api_termination" { default = true }
variable "additional_security_group_ids" { default = [] }
variable "application" {}
variable "environment" {}
variable "owner" {}
variable "support_group" {}
variable "aws_region" {}
variable "instance_name" {}

