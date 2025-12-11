locals {
  create_sg       = var.security_group_id == "" ? true : false
  use_kms         = var.kms_key_id != "" ? true : false
  use_provisioned = var.throughput_mode == "provisioned" ? true : false
}

# ---------------------------
# Create SG Only If Not Provided
# ---------------------------
resource "aws_security_group" "efs_sg" {
  count = local.create_sg ? 1 : 0

  name        = "efs-mount-sg"
  description = "EFS mount target SG (allow NFS)"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "efs-sg" })
}

locals {
  final_sg = local.create_sg ? aws_security_group.efs_sg[0].id : var.security_group_id
}

# ---------------------------
# EFS FILESYSTEM (NO BACKUP POLICY HERE!)
# ---------------------------
resource "aws_efs_file_system" "this" {
  encrypted = true

  kms_key_id       = local.use_kms ? var.kms_key_id : null
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode

  provisioned_throughput_in_mibps = local.use_provisioned ? var.provisioned_throughput_in_mibps : null

  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"
  }

  tags = merge(var.tags, { Name = "efs-app" })
}

# ---------------------------
# EFS BACKUP POLICY (NEW RESOURCE FOR PROVIDER 6.x)
# ---------------------------
resource "aws_efs_backup_policy" "efs_backup" {
  file_system_id = aws_efs_file_system.this.id

  backup_policy {
    status = var.enable_automatic_backups ? "ENABLED" : "DISABLED"
  }
}

# ---------------------------
# Mount Targets
# ---------------------------
resource "aws_efs_mount_target" "mt1" {
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.subnet_id1
  security_groups = [local.final_sg]
}

resource "aws_efs_mount_target" "mt2" {
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.subnet_id2
  security_groups = [local.final_sg]
}
