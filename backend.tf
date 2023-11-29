# terraform { 
# backend "s3" { 
# bucket = "dkhundley-terraform-test" 
# key = "terraform-sagemaker-tutorial.tfstate" 
# region = "us-east-1" 
# } 
# } 
provider "aws" {
  región = "us-east-1"
}