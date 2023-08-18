module "vars" {
  source = "../lab_var"

  lab_file = var.lab_file
}

locals {
  configuration         = module.vars.configuration
  global_variables      = module.vars.global_variables
  global_tags           = module.vars.tags
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "access_key_private" {
  type = string
}

variable "secret_key_private" {
  type = string
}

variable "lab_file" {
  type = string
  description = "The lab variable file to run"
}