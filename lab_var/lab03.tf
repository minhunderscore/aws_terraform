locals {
  lab03 = {
    ##########################
    # S3 CONFIG
    ##########################
    s3 = {
      pipeline_artifact = {
        module_name = "pipeline-artifact"
      }
      s3_storage = {
        module_name = "s3-storage"
      }
    }

    ##########################
    # Key CONFIG
    ##########################
    key = {

    }

    ##########################
    # EC2 CONFIG
    ##########################
    instance_config = {
      "public-ec2-1" = {
        ami            = "ami-0a709bebf4fa9246f"
        instance_type  = "t2.micro"
        subnet         = "public-subn-1"
        security_group = "sd-1"
      }
      "private-ec2-1" = {
        ami            = "ami-0a709bebf4fa9246f"
        instance_type  = "t2.micro"
        subnet         = "private-subn-1"
        security_group = "sd-1"
      }
    }
    # tags = {
    #   Name = "minhph"
    # }

    ##########################
    # VPC CONFIG
    ##########################
    vpc_config = {
      cidr_block = "10.0.0.0/16"
      subnets = {
        "private-subn-1" = {
          cidr_block              = "10.0.1.0/24"
          availability_zone       = "ap-southeast-2a"
          map_public_ip_on_launch = false
          route_table             = "private-subn-rb"
        }
        "private-subn-2" = {
          cidr_block              = "10.0.2.0/24"
          availability_zone       = "ap-southeast-2b"
          map_public_ip_on_launch = false
          route_table             = "private-subn-rb"
        }
        "public-subn-1" = {
          cidr_block              = "10.0.3.0/24"
          availability_zone       = "ap-southeast-2a"
          map_public_ip_on_launch = true
          route_table             = "public-subn-rb"
        }
        "public-subn-2" = {
          cidr_block              = "10.0.4.0/24"
          availability_zone       = "ap-southeast-2b"
          map_public_ip_on_launch = true
          route_table             = "public-subn-rb"
        }
      }
      internet_gateway = true
      nat_gateways = {
        "nat-gw-1" = {
          subnet = "public-subn-1"
        }
      }
      security_groups = {
        "sd-1" = {
          name        = "sydney-rule"
          description = "Allow SSH Inbound Outbound"
          ingress = [
            {
              protocol   = "tcp"
              from_port  = 22
              to_port    = 22
              cidr_block = ["0.0.0.0/0"]
            }
          ],
          egress = [
            {
              protocol   = "tcp"
              from_port  = 23
              to_port    = 80
              cidr_block = ["0.0.0.0/0"]
            }
          ]
        }
      }
    }
  }
}