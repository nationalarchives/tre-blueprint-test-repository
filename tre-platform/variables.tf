variable "prefix" {
  description = "Prefix for transformation engine resources"
  type        = string
}

variable "assume_roles" {
  description = "role ARNs to be assumed"
  type = object({
    mngmt   = string
    users   = string
    nonprod = string
    prod    = string
  })
}

variable "external_id" {
  description = "External ID for cross account roles"
  type        = string
}

variable "tre_platform_repositories" {
  description = "List TRE repositories that require access to tre AWS Accounts"
  type        = list(string)
}

variable "tre_prod_repositories" {
  description = "List TRE repositories for prod environments that require access to tre AWS Accounts"
  type        = list(string)
}

variable "tre_nonprod_repositories" {
  description = "List TRE repositories for nonprod environments that require access to tre AWS Accounts"
  type        = list(string)
}


