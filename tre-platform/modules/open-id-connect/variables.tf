variable "prefix" {
  description = "Prefix for transformation engine resources"
  type        = string
}

variable "tre_github_actions_open_id_connect_roles" {
  description = "List TRE repositories that require access to tre AWS Accounts"
  type = list(object({
    name             = string
    tre_repositories = list(string)
  }))
}

variable "tre_github_actions_open_id_connect_policies" {
  description = "List TRE repositories that require access to tre AWS Accounts"
  type = list(object({
    name            = string
    terraform_roles = list(string)
  }))
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}
