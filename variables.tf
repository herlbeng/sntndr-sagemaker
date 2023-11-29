variable "access_key" {
  description = "access_key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "secret_key"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "region" {
  type = string
}

variable "runtime" {
  type = string
  default = "python3.10.9"
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