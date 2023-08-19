##########################
# TAGGING MODULE
##########################

module "tagging" {
  source = "../common_modules/tagging"

  environment    = local.global_tags.environment
  provisioned_by = local.global_tags.provisioned_by
  project        = local.global_tags.project
  owner          = local.global_tags.owner
  name           = local.global_tags.name
}


##########################
# S3 MODULE
##########################

module "s3" {
  source = "../common_modules/s3"

  for_each = local.configuration.s3

  global_variables = local.global_variables
  module_name      = each.value.module_name
  tags             = module.tagging.tags
}

##########################
# EC2 MODULE
##########################

module "ec2" {
  source = "../common_modules/ec2"
  instance_config = {
    for key, value in local.configuration.instance_config :
    key => merge(value,
      {
        subnet_id         = module.vpc.subnets[value.subnet].id
        security_group_id = [module.vpc.security_groups[value.security_group].id]
      }
    )
  }
}

##########################
# VPC MODULE
##########################

module "vpc" {
  source     = "../common_modules/vpc"
  vpc_config = local.configuration.vpc_config
}

##########################
# Key MODULE
##########################

# module "key" {
#   source                = "../common_modules/key_pair"
#   key = local.configuration.key
# }