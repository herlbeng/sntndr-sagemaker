
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
  name               = "sagemaker_domain_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
}

resource "aws_iam_role" "sagemaker_exec_role" {
  for_each           = var.user_profile_names
  name               = "${var.project_name}_${each.key}_exec-role"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
}

resource "aws_sagemaker_domain" "sagemakerDomainPOC" {
  domain_name = "sagemakerDomainPOC"
  auth_mode   = "IAM"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnets

  default_user_settings {
    execution_role = aws_iam_role.sagemaker_domain_role.arn
  }
}

resource "aws_sagemaker_user_profile" "mlops_profile" {
  for_each          = var.user_profile_names
  domain_id         = aws_sagemaker_domain.sagemakerDomainPOC.id #"d-0v5zdh7zffd0" #"d-wxhuu1mbq9pm" #"d-s8hloa35njwk"
  user_profile_name = each.key

  user_settings {
    execution_role = aws_iam_role.sagemaker_exec_role[each.key].arn
  }
  tags = {
    Name = "mlops"
  }
}

#POLICIES
resource "aws_iam_policy" "sagemaker_data_engineering_policy" {
  name = "${var.project_name}-sagemaker-data-engineering_policy"
  path = "/"
  tags = {
    type_policy = "local"
  }
  policy = <<-EOF
  {
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : "s3:*",
        "Resource" : [
          "${var.bucket_training_data_arn}",
          "${var.bucket_output_models_arn}",
          "${var.bucket_training_data_arn}/*",
          "${var.bucket_output_models_arn}/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "sagemaker:PutRecord",
          "sagemaker:ListApps",
          "sagemaker:ListDomains"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow"
        "Action" : "ec2:RunInstances"
        "Resource" : "*",
        "Condition" : {
          "StrinEquals" : {
            "2c2:InstanceType":"t1.micro"
          }
        }
      }
    ]
  }
  EOF 
}