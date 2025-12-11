variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "kms_key_arn" {
  description = "Optional KMS key ARN for SSE-KMS. If empty, AES256 is used."
  type        = string
  default     = ""
}

variable "enable_logging" {
  description = "Enable access logging"
  type        = bool
  default     = false
}

variable "logging_target_bucket" {
  description = "Bucket to store access logs (required if logging enabled)"
  type        = string
  default     = null
}

variable "lifecycle_to_ia_days" {
  description = "Transition to STANDARD_IA in days"
  type        = number
  default     = 30
}

variable "lifecycle_to_glacier_days" {
  description = "Transition to GLACIER in days"
  type        = number
  default     = 90
}

variable "expire_after_days" {
  description = "Expiration in days"
  type        = number
  default     = 3650
}

variable "enable_replication" {
  description = "Enable cross-region replication"
  type        = bool
  default     = false
}

variable "replication_destination_bucket_arn" {
  description = "Destination bucket ARN for replication"
  type        = string
  default     = null
}

variable "replication_role_name" {
  description = "IAM role for replication"
  type        = string
  default     = "crr-replication-role"
}

variable "versioning_enabled" {
  description = "Enable versioning"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
