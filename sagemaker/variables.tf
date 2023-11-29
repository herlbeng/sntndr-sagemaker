variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "user_profile_names" {
  description = "value"
  type        = set(string)
}

variable "bucket_training_data_arn" {
    type = string
    description = "bucket_training_data_arn"
}

variable "bucket_output_models_arn" {
    type = string
    description = "bucket_output_models_arn"
}