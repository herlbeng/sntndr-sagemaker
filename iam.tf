## DATA BLOCKS
## ----------------------------------------------------------------

# Defining the SageMaker "Assume Role" policy
data "aws_iam_policy_document" "sm_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

## RESOURCE BLOCKS
## ----------------------------------------------------------------

# Defining the SageMaker notebook IAM role
resource "aws_iam_role" "notebook_iam_role" {
  name               = "${var.project_name}-sm-notebook-role"
  assume_role_policy = data.aws_iam_policy_document.sm_assume_role_policy.json
}

# Attaching the AWS default policy, "AmazonSageMakerFullAccess"
resource "aws_iam_policy_attachment" "sm_full_access_attach" {
  name       = "${var.project_name}-sm-full-access-attachment"
  roles      = [aws_iam_role.notebook_iam_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}


## DE OTRO CODIGO
## ----------------------------------------------------------------

resource "aws_iam_role" "sagemaker_domain_role" {
  name = "${var.project_name}-sagemaker_domain_role"
  path = "/"
  #  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
  assume_role_policy = data.aws_iam_policy_document.sm_assume_role_policy.json
}

resource "aws_iam_role" "sagemaker_exec_role" {
  for_each = var.user_profile_names
  name     = "${var.project_name}_${each.key}_exec-role"
  #  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
  assume_role_policy = data.aws_iam_policy_document.sm_assume_role_policy.json
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