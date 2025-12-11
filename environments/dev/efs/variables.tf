variable "vpc_id" {}
variable "subnet_id1" {}
variable "subnet_id2" {}
variable "security_group_id" {
  default = ""
}
variable "kms_key_id" {
  default = ""
}
variable "enable_automatic_backups" {
  default = true
}
variable "performance_mode" {
  default = "generalPurpose"
}
variable "throughput_mode" {
  default = "bursting"
}
variable "provisioned_throughput_in_mibps" {
  default = 0
}
variable "region" {
  type = string
}
