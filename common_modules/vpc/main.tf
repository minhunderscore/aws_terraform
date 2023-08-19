resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name = "minhph_vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  for_each                = var.vpc_config.subnets
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  #   tags = {
  #     Name = "minhph_subnet_{}"
  #   }
}

resource "aws_eip" "eip" {
  #   instance = aws_instance.instance.id
  for_each = var.vpc_config.nat_gateways
  vpc      = true
}

resource "aws_internet_gateway" "ig" {
  vpc_id   = aws_vpc.vpc.id
  for_each = var.vpc_config.internet_gateway == true ? toset(["1"]) : []
}

resource "aws_security_group" "sg" {
  vpc_id      = aws_vpc.vpc.id
  for_each    = var.vpc_config.security_groups
  name        = each.value.name
  description = each.value.description
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      protocol    = ingress.value.protocol
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_block
    }
  }
  dynamic "egress" {
    for_each = each.value.egress
    content {
      protocol    = egress.value.protocol
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      cidr_blocks = egress.value.cidr_block
    }
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.subnet[each.value.subnet].id
  for_each      = var.vpc_config.nat_gateways
  allocation_id = aws_eip.eip[each.key].id
}
