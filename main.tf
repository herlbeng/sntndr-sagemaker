provider "aws" {
  region     = "us-east-1"
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
  name               = "${var.project_name}-sagemaker_domain_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
}

resource "aws_iam_role" "sagemaker_exec_role" {
  for_each           = var.user_profile_names
  name               = "${var.project_name}_${each.key}_exec-role"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
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

resource "aws_sagemaker_user_profile" "user_profile" {
  for_each          = var.user_profile_names
  domain_id         = aws_sagemaker_domain.sagemakerDomain.id #"d-0v5zdh7zffd0" #"d-wxhuu1mbq9pm" #"d-s8hloa35njwk"
  user_profile_name = each.key

  user_settings {
    execution_role = aws_iam_role.sagemaker_exec_role[each.key].arn
  }
  tags = {
    Name = "mlops"
  }
}