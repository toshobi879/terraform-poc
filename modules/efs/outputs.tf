output "efs_id" {
  value = aws_efs_file_system.this.id
}

output "efs_sg_id" {
  value = local.final_sg
}
