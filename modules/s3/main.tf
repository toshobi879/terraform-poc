# S3 bucket
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name


}

# Block public access
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Versioning
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

# Server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_key_arn != "" ? "aws:kms" : "AES256"
      kms_master_key_id = var.kms_key_arn != "" ? var.kms_key_arn : null
    }
  }
}

# TLS and unencrypted upload enforcement via bucket policy
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "EnforceTLS"
        Effect = "Deny"
        Principal = "*"
        Action = "s3:*"
        Resource = [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = false
          }
        }
      },
      {
        Sid = "DenyUnencryptedObjectUploads"
        Effect = "Deny"
        Principal = "*"
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.this.arn}/*"
        Condition = {
          StringNotEqualsIfExists = {
            "s3:x-amz-server-side-encryption" = var.kms_key_arn != "" ? "aws:kms" : "AES256"
          }
        }
      }
    ]
  })
}

# Optional logging
resource "aws_s3_bucket_logging" "this" {
  count  = var.enable_logging ? 1 : 0
  bucket = aws_s3_bucket.this.id
  target_bucket = var.logging_target_bucket
  target_prefix = "access-logs/${var.bucket_name}/"
}

# Optional replication
resource "aws_iam_role" "replication_role" {
  count = var.enable_replication ? 1 : 0
  name  = var.replication_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_s3_bucket_replication_configuration" "this" {
  count = var.enable_replication ? 1 : 0
  bucket = aws_s3_bucket.this.id
  role   = aws_iam_role.replication_role[0].arn

  rule {
    id     = "default-crr"
    status = "Enabled"

    destination {
      bucket        = var.replication_destination_bucket_arn
      storage_class = "STANDARD"
    }
  }

  depends_on = [aws_s3_bucket_versioning.this]
}
