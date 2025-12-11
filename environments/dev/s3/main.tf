module "s3" {
  source = "../../../modules/s3"

  bucket_name                        = var.bucket_name
  kms_key_arn                        = var.kms_key_arn
  enable_logging                     = var.enable_logging
  logging_target_bucket              = var.logging_target_bucket
  enable_replication                 = var.enable_replication
  replication_destination_bucket_arn = var.replication_destination_bucket_arn
  replication_role_name              = var.replication_role_name
  versioning_enabled                 = var.versioning_enabled
  tags                               = merge(var.tags, local.common_tags)
}
