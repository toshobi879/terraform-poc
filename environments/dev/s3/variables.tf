variable "environment" {
  type        = string
}
variable "bucket_name" {}
variable "kms_key_arn" { default = "" }
variable "enable_logging" { default = false }
variable "logging_target_bucket" { default = "" }
variable "enable_replication" { default = false }
variable "replication_destination_bucket_arn" { default = "" }
variable "replication_role_name" { default = "crr-replication-role" }
variable "versioning_enabled" { default = true }
variable "tags" { default = {} }
variable "aws_region" {
  type        = string
}
