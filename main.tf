terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# configure the AWS provider
provider "aws" {
  region = "us-west-2"
}


#This just lets terraform know that we want to use the AWS provider, and that we’ll be working in the eu-west-1 region.