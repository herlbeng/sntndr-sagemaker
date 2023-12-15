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
  name               = "${project_name}-sm-notebook-role"
  assume_role_policy = data.aws_iam_policy_document.sm_assume_role_policy.json
}

# Attaching the AWS default policy, "AmazonSageMakerFullAccess"
resource "aws_iam_policy_attachment" "sm_full_access_attach" {
  name       = "${project_name}-sm-full-access-attachment"
  roles      = [aws_iam_role.notebook_iam_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}