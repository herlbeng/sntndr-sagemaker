output "bucket_training_data_arn" {
    value = aws_s3_bucket.training_data.arn
}

output "bucket_output_models_arn" {
    value = aws_s3_bucket.output_models.arn
}

output "bucket_training_data_bucket" {
    value = aws_s3_bucket.training_data.bucket
}

output "bucket_output_models_bucket" {
    value = aws_s3_bucket.output_models.bucket
}
