output "aws_sagemaker_user_profile" {
  value = { for profile_name, i in aws_sagemaker_user_profile.mlops_profile : profile_name => i.user_profile_name }
}