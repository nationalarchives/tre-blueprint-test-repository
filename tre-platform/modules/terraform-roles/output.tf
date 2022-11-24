output "terraform_role_arn" {
  value       = aws_iam_role.tre_terraform.arn
  description = "ARN of the TRE Environments Terraform Role"
}

output "tre_break_glass_terraform_role_arn" {
  value       = aws_iam_role.tre_break_glass_terraform.arn
  description = "ARN of the TRE Break Glass Terraform Role"
}
