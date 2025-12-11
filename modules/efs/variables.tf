variable "vpc_id" {
  type = string
}

variable "subnet_id1" {
  type = string
}

variable "subnet_id2" {
  type = string
}

variable "security_group_id" {
  type        = string
  default     = ""
  description = "Optional existing SG ID; leave blank to create new SG."
}

variable "performance_mode" {
  type    = string
  default = "generalPurpose"
}

variable "throughput_mode" {
  type    = string
  default = "bursting"
}

variable "provisioned_throughput_in_mibps" {
  type    = number
  default = 0
}

variable "kms_key_id" {
  type    = string
  default = ""
}

variable "enable_automatic_backups" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
