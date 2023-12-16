provider "aws" {
  region = "us-east-1"
}

resource "aws_sagemaker_domain" "sagemakerDomain" {
  domain_name = "${var.project_name}-domain"
  auth_mode   = "IAM"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnets

  default_user_settings {
    execution_role = aws_iam_role.sagemaker_domain_role.arn
  }
}
