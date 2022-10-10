terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

/* Value fetched from terraform.tfvars */
provider "aws" {
  profile    = "awsdaph"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}
