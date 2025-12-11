variable "aws_region" {
  type = string
}

variable "rds_subnet_ids" {
  type        = list(string)
  description = "Two private subnet IDs for RDS"
}

variable "vpc_id" {
  type = string
}

variable "db_engine" {
  type    = string
  default = "postgres"
}

variable "db_engine_version" {
  type    = string
  default = "15"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "storage_type" {
  type    = string
  default = "gp3"
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "kms_key_id" {
  type    = string
  default = ""
}

variable "master_username" {
  type    = string
  default = "masteruser"
}

variable "master_user_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "backup_retention_days" {
  type    = number
  default = 7
}

variable "preferred_backup_window" {
  type    = string
  default = "05:30-06:30"
}

variable "preferred_maintenance_window" {
  type    = string
  default = "Sun:07:00-Sun:08:00"
}

variable "deletion_protection" {
  type    = bool
  default = true
}

variable "allowed_cidr_for_db_port" {
  type    = string
  default = ""
}

variable "allowed_security_group_id" {
  type    = string
  default = ""
}

variable "enable_performance_insights" {
  type    = bool
  default = true
}

variable "enabled_cloudwatch_logs_exports" {
  type    = list(string)
  default = []
}

variable "application" {
  description = "Application name tag"
  type        = string
  default     = "MyApp"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}
