provider "aws" {
  region = "eu-west-2"
  assume_role {
    role_arn = var.assume_role
  }
}

terraform {
  required_version = "1.3.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
  }
}

module "tre_bp_poc" {
  source = "../terraform-modules/tre-bp-poc"
  env = var.env
  prefix = var.prefix
  assume_role = var.assume_role
}
