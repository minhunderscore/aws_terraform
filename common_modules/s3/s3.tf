resource "aws_s3_bucket" "this" {
  bucket        = local.prefix_name
  force_destroy = true

  tags = var.tags
}

resource "aws_s3_bucket_object" "this" {
  bucket = aws_s3_bucket.this.id
  key    = "*"
  acl    = "private"
}

resource "aws_kms_key" "this" {
  description             = "this is a kms key for s3 ${local.prefix_name}"
  deletion_window_in_days = 10

  tags = var.tags
}

resource "aws_kms_key_policy" "this" {
  key_id = aws_kms_key.this.id
  policy = jsonencode({
    Id = "${local.prefix_name}"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.this.arn
      sse_algorithm     = "aws:kms"
    }
  }
}