terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<= 5.26.0"
    }
  }

  backend "s3" {
    bucket = "sgmkr-tf-mlops"
    key    = "sgmkr-tf-mlops.tfstate"
    region = "us-east-1"
  }

  required_version = ">= 1.6.0"
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}