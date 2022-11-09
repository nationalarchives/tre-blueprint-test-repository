provider "aws" {
  region = "eu-west-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
  }
}

resource "aws_s3_bucket" "foo" {
  bucket = "tre-test-workspace-2"
}

resource "aws_s3_bucket_public_access_block" "foo" {

  bucket                  = aws_s3_bucket.foo.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "foo" {
  bucket = aws_s3_bucket.foo.id
  acl    = "private"
}
