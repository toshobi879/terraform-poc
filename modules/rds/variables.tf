variable "subnet_ids" {
  description = "List of subnet IDs for DB subnet group (private subnets)"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "db_engine" {
  description = "Database engine"
  type        = string

}

variable "engine_port" {
  description = "DB engine port"
  type        = number
  default     = 5432
}

variable "db_engine_version" {
  description = "Engine version"
  type        = string
  default     = "15"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage (GB)"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Storage type (gp3,gp2,io1,io2)"
  type        = string
  default     = "gp3"
}

variable "multi_az" {
  description = "Enable Multi-AZ"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "Optional KMS Key ID/ARN (empty string to not use)"
  type        = string
  default     = ""
}

variable "master_username" {
  description = "Master DB username"
  type        = string
  default     = "masteruser"
}

variable "master_user_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name"
  type        = string

}

variable "backup_retention_days" {
  description = "Backup retention days"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "Preferred backup window"
  type        = string
  default     = "05:30-06:30"
}

variable "preferred_maintenance_window" {
  description = "Preferred maintenance window"
  type        = string
  default     = "Sun:07:00-Sun:08:00"
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "allowed_cidr" {
  description = "Optional CIDR allowed to access DB port (empty string to disable)"
  type        = string
  default     = ""
}

variable "allowed_security_group_id" {
  description = "Optional security group ID permitted to access DB (empty string to disable)"
  type        = string
  default     = ""
}

variable "enable_performance_insights" {
  description = "Enable Performance Insights"
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Enable log exports (e.g. [\"postgresql\"])"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
