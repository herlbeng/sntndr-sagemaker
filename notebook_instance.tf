# Creating the SageMaker notebook instance
variable "project_name" {}

resource "aws_sagemaker_notebook_instance" "notebook_instance" {
  name                    = "${var.project_name}-notebook"
  role_arn                = aws_iam_role.notebook_iam_role.arn
  instance_type           = "ml.t2.medium"
  lifecycle_config_name   = aws_sagemaker_notebook_instance_lifecycle_configuration.notebook_config.name
  default_code_repository = aws_sagemaker_code_repository.git_repo.code_repository_name
}