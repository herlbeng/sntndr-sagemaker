# Defining the SageMaker notebook lifecycle configuration
resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "notebook_config" {
  name      = "${var.project_name}-lifecycle-config"
  on_create = filebase64("scripts/on-create.sh")
  on_start  = filebase64("scripts/on-start.sh")
}