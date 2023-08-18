locals {
  global_variables = {
    environment = "prod"
    owner       = "minhph22"
    project     = "gr3"
  }

  tags = {
    environment    = "dev"
    owner          = "minhph22"
    name           = "minhph22"
    project        = "gr3"
    provisioned_by = "terraform"
  }
}