# Defining the Git repo to instantiate on the SageMaker notebook instance
resource "aws_sagemaker_code_repository" "git_repo" {
  code_repository_name = "${var.project_name}-code-repository"

  git_config {
    repository_url = "https://github.com/herlbeng/sntndr-sagemaker.git"
  }
}   