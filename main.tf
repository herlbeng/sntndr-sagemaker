provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

data "aws_iam_policy_document" "sagemaker_assume_role" {
  statement {
    actions = ["iam:CreateRole"]
    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazon.com"]
    }
  }
}

resource "aws_iam_role" "sagemaker_domain_role" {
  name               = "${project_name}-sagemaker_domain_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
}

resource "aws_sagemaker_studio_domain" "sagemakerDomain" {
  domain_name = "${project_name}-domain"
  auth_mode   = "IAM"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnets

  default_user_settings {
    execution_role = aws_iam_role.sagemaker_domain_role.arn
  }
}