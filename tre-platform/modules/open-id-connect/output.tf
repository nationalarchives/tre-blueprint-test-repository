output "tre_open_id_connect_roles" {
  value       = { for key, value in aws_iam_role.tre_github_actions_open_id_connect : key => value.arn }
  description = "ARN of the tre-github-actions-open-id-connect-role"
}

output "tre_github_actions_open_id_connect" {
  value       = aws_iam_openid_connect_provider.tre_github_actions.arn
  description = "ARN of the TRE GitHub Actions OpenID Connnect"
}
