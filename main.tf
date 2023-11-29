data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

module "s3" {
  source = "./s3"
  s3_bucket_input_training_path = local.s3_bucket_input_training_path
  s3_object_training_data = local.s3_object_training_data
  s3_bucket_output_models_path = local.s3_bucket_output_models_path
}

module "sagemaker" {
  source = "./sagemaker"
  project_name = var.project_name
  bucket_training_data_arn = module.s3.bucket_training_data_arn
  bucket_output_models_arn = module.s3.bucket_output_models_arn
  user_profile_names = var.user_profile_names
}