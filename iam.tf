## DATA BLOCKS
## ----------------------------------------------------------------

# Defining the SageMaker "Assume Role" policy
data "aws_iam_policy_document" "sm_assume_role_policy" {
  statement {
    
    actions = ["sts:AssumeRole", "iam:CreateRole"]
    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazon.com"]
    }
  }
}

## RESOURCE BLOCKS
## ----------------------------------------------------------------

# Defining the SageMaker notebook IAM role
resource "aws_iam_role" "notebook_iam_role" {
  name               = "${var.project_name}-sm-notebook-role"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
}

# Attaching the AWS default policy, "AmazonSageMakerFullAccess"
resource "aws_iam_policy_attachment" "sm_full_access_attach" {
  name       = "${var.project_name}-sm-full-access-attachment"
  roles      = [aws_iam_role.notebook_iam_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}