locals {

  default_tags = {
    Region        = data.aws_region.current.name
    Environment   = var.environment
    Owner         = var.owner
    Name          = var.name
    Project       = var.project
    ProvisionedBy = var.provisioned_by
  }
  # Loop to check that tag have defined, create map of default tag
  default_tags_map = { for item in keys(local.default_tags) : item => local.default_tags[item] if local.default_tags[item] != null }
  # Merge two map tag
  tags = merge(local.default_tags_map)
}

