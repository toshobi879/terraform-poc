module "efs" {
  source = "../../../modules/efs"

  vpc_id   = var.vpc_id
  subnet_id1 = var.subnet_id1
  subnet_id2 = var.subnet_id2

  security_group_id = var.security_group_id
  kms_key_id        = var.kms_key_id

  enable_automatic_backups            = var.enable_automatic_backups
  performance_mode                    = var.performance_mode
  throughput_mode                     = var.throughput_mode
  provisioned_throughput_in_mibps     = var.provisioned_throughput_in_mibps

  tags = local.common_tags
}
