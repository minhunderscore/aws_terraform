output "s3_bucket" {
  value = aws_s3_bucket.this.id
}

output "kms_key_id" {
  value = aws_kms_key.this.key_id
}