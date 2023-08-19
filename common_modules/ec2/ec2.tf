resource "aws_instance" "instance" {
  for_each        = var.instance_config
  instance_type   = each.value.instance_type
  ami             = each.value.ami_id
  subnet_id       = each.value.subnet_id
  security_groups = each.value.security_group_id
  user_data = base64encode(
    <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y nginx
    systemctl start nginx
    systemctl enable nginx
    EOF
  )

}
