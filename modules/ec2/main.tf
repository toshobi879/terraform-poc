resource "aws_security_group" "instance_sg" {
  name        = "${var.application}-${var.environment}-sg"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allow_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.application}-${var.environment}-sg"
  })
}

resource "aws_iam_role" "instance_role" {
  name = "${var.application}-${var.environment}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.application}-${var.environment}-profile"
  role = aws_iam_role.instance_role.name
}

resource "aws_instance" "this" {
  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  disable_api_termination = var.disable_api_termination
  vpc_security_group_ids = concat([aws_security_group.instance_sg.id], var.additional_security_group_ids)

  root_block_device {
    volume_size = var.volume_size_gib
    volume_type = var.volume_type
    encrypted   = true
  }

  user_data = <<-EOT
    #!/bin/bash
    yum update -y
    systemctl enable amazon-ssm-agent && systemctl start amazon-ssm-agent
  EOT

  tags = merge(var.common_tags, {
    Name = var.instance_name
  })
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
