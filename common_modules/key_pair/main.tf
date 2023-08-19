resource "aws_key_pair" "key_pair" {
  for_each   = var.key_config
  key_name   = each.var.key_name
  public_key = each.var.public_key
}


