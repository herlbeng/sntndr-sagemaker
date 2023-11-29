variable s3_bucket_input_training_path {
    type = string
    description = "S3 path where training data is stored"
}

variable s3_object_training_data {
    type = string
    description = "S3 object where training data is stored"
}

variable s3_bucket_output_models_path {
    type = string
    description = "S3 path where teh output (trained data) will be store"
}
