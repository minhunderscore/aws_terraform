resource "aws_key_pair" "key_pair" {
  # for_each   = var.key_config
  key_name   = var.key_config.key_name
  public_key = var.key_config.public_key
}


