# Output the ARN of the IAM role
output "iam_role_arn" {
  value       = aws_iam_role.SSMAutomationPackerRole.arn
  description = "The ARN of the IAM role used for Packer automation"
}

# Output the name of the IAM instance profile associated with the Packer role
output "instance_profile_name" {
  value       = aws_iam_instance_profile.SSMAutomationPackerInstanceProfile.name
  description = "The name of the IAM instance profile associated with the Packer role"
}
