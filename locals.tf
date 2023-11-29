locals {
  #s3_bucket_input_training_path = "${var.project_name}-training-data-${data.aws_caller_identity.current.account_id}"  
  #s3_bucket_input_training_path = "sgmkr-tf-mlops-training-data"
  s3_bucket_input_training_path = "arn:aws:s3:::sgmkr-tf-mlops-training-data"
  #s3_bucket_output_models_path = "${var.project_name}-output-models-${data.aws_caller_identity.current.account_id}"  
  s3_bucket_output_models_path = "arn:aws:s3:::sgmkr-tf-mlops-output-models"
  s3_object_training_data = "./data/iris.csv"
}

