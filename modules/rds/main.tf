
resource "aws_security_group" "db_sg" {
  name        = "${var.db_name}-rds-sg"
  description = "RDS access SG"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group_rule" "ingress_cidr" {
  count            = var.allowed_cidr != "" ? 1 : 0
  type             = "ingress"
  from_port        = var.engine_port
  to_port          = var.engine_port
  protocol         = "tcp"
  cidr_blocks      = [var.allowed_cidr]
  security_group_id = aws_security_group.db_sg.id
  description      = "CIDR-based DB access"
}

resource "aws_security_group_rule" "ingress_sg" {
  count             = var.allowed_security_group_id != "" ? 1 : 0
  type              = "ingress"
  from_port         = var.engine_port
  to_port           = var.engine_port
  protocol          = "tcp"
  source_security_group_id = var.allowed_security_group_id
  security_group_id = aws_security_group.db_sg.id
  description       = "SG-based DB access"
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "${var.db_name}-subnets"
  subnet_ids  = var.subnet_ids
  description = "Private subnets for RDS"

  tags = var.tags
}

resource "aws_db_instance" "database" {
  identifier              = "${var.db_name}-${var.db_engine}"
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  db_name                 = var.db_name
  username                = var.master_username
  password                = var.master_user_password
  multi_az                = var.multi_az
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  publicly_accessible     = false
  deletion_protection     = var.deletion_protection
  storage_encrypted       = true
  kms_key_id              = var.kms_key_id != "" ? var.kms_key_id : null
  backup_retention_period = var.backup_retention_days
  backup_window = var.preferred_backup_window
  maintenance_window      = var.preferred_maintenance_window
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  performance_insights_enabled = var.enable_performance_insights

  # common tags
  tags = var.tags

  lifecycle {
    prevent_destroy = false
  }
}
