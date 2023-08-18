provider "aws" {
  region     = "ap-southeast-2"
  access_key = var.access_key_private
  secret_key = var.secret_key_private
}

terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}