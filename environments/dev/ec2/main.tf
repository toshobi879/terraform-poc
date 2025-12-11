
module "ec2" {
  source = "../../../modules/ec2"

  vpc_id                        = var.vpc_id
  subnet_id                     = var.subnet_id
  instance_type                 = var.instance_type
  ami_id                        = var.ami_id
  key_name                      = var.key_name
  volume_size_gib               = var.volume_size_gib
  volume_type                   = var.volume_type
  allow_ssh_cidr                = var.allow_ssh_cidr
  disable_api_termination       = var.disable_api_termination
  additional_security_group_ids = var.additional_security_group_ids
  application                   = var.application
  environment                   = var.environment
  owner                         = var.owner
  support_group                 = var.support_group
  aws_region                    = var.aws_region
  instance_name                 = var.instance_name
  common_tags                   = local.common_tags
}
