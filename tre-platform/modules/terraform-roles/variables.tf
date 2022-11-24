variable "prefix" {
  description = "Prefix for transformation engine resources"
  type        = string
}

variable "tre_open_id_connect_roles" {
  description = "ARN of the OpenID Connect Roles in the management account"
  type        = string
}

variable "tre_open_id_connect_platform_role" {
  description = "ARN of the OpenID Connect Platform Role in the management account"
  type        = string
}


variable "permission_boundary_policy_path" {
  description = "Path to the tre permission boundary policy"
  type        = string
}

variable "terraform_policy_path" {
  description = "Path to the tre terraform role policy"
  type        = string
}

variable "terraform_iam_policy_path" {
  description = "Path to the tre terraform role iam policy"
  type        = string
}

variable "tre_break_glass_terraform_policy" {
  description = "Path to the tre break glass policy"
  type        = any
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "external_id" {
  description = "Zaizi external ID for role assumption"
  type        = string
}