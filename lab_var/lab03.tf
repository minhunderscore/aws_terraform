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
    # KEY CONFIG
    ##########################
    key_config = {
      key_name   = "key_1"
      public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzbDnAAHcTWzL24sc8NcBdAATdotX7+S/PuApn/l1XhNCzPy4gSdikVaRSYOwdql5ysvC9rETuXeAd8BcIsS/QpOQlob9x8CiMzk3G2rlzTtAKwIix+CnJK2T2TsN44RpTapDRdcBYk8LVyqlgOLt35rvEgPhL9oTibok5mPTc/630P2dsYlvsMMvyEZ73c+PXWIYj/HXSjBKOx5HdmUURbTtIHkgv4+8+QaAaOiwoWnOC2XpD9e9PpOovW06zCdPj7AnWwMxWmbLac+TEo48vJ9XX2h9KswT2687DIQmwQGd1MbXz5P/H6FW3TQvG//1G4zMHXZ7yn1q9MmHl2VAq5ZKAGZeGu4zFTGXln69/BBlceq3snC/TGXC0Q7nft1JYKQyQmUdauLe/jdT35q9hbEE2yDAF7LGo+O+mEVOoU462gC26mx9wIqRta+TU+9Yb8yJiu464EBh1vz0mKYJ2M2AIo2glytAx6D6C2AvQtJVpb9WsemxIh0DOPRHQgck= Admin@KALI-LINUX"
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
          description = "Allow popular Inbound Outbound"
          ingress = [
            {
              protocol   = "tcp"
              from_port  = 0
              to_port    = 1024
              cidr_block = ["0.0.0.0/0"]
            }
          ],
          egress = [
            {
              protocol   = "tcp"
              from_port  = 0
              to_port    = 1024
              cidr_block = ["0.0.0.0/0"]
            }
          ]
        }
      }
      route_tables = {
        "public-subn-rb" = {
          route = [
            {
              destination_cidr_block = "0.0.0.0/0"
              gateway                = "internet_gateway"
            }
          ]
        },
        "private-subn-rb" = {
          route = [
            {
              destination_cidr_block = "0.0.0.0/0"
              nat_gateway            = "nat-gw-1"
            }
          ]
        }
      }
    }
  }
}