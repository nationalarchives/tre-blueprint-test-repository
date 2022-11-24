locals {
  tre_github_actions_open_id_connect_policies = [
    {
      name = "platform"
      terraform_roles = [
        module.tre_prod_terraform_roles.terraform_role_arn,
        module.tre_nonprod_terraform_roles.terraform_role_arn,
        module.tre_users_terraform_roles.terraform_role_arn,
        module.tre_management_terraform_roles.terraform_role_arn,
        module.tre_prod_terraform_roles.tre_break_glass_terraform_role_arn,
        module.tre_nonprod_terraform_roles.tre_break_glass_terraform_role_arn,
        module.tre_users_terraform_roles.tre_break_glass_terraform_role_arn,
        module.tre_management_terraform_roles.tre_break_glass_terraform_role_arn,
      ]
    },
    {
      name = "nonprod"
      terraform_roles = [
        module.tre_nonprod_terraform_roles.terraform_role_arn,
      ]
    },
    {
      name = "prod"
      terraform_roles = [
        module.tre_prod_terraform_roles.terraform_role_arn
      ]
    }
  ]

  tre_github_actions_open_id_connect_roles = [
    {
      name             = "platform"
      tre_repositories = var.tre_platform_repositories
    },
    {
      name             = "nonprod"
      tre_repositories = var.tre_nonprod_repositories
    },
    {
      name             = "prod"
      tre_repositories = var.tre_prod_repositories
    }
  ]

  tre_terraform_platform_resources = [
    module.tre_prod_terraform_roles.terraform_role_arn,
    module.tre_nonprod_terraform_roles.terraform_role_arn,
    module.tre_users_terraform_roles.terraform_role_arn,
    module.tre_management_terraform_roles.terraform_role_arn,
    module.tre_prod_terraform_roles.tre_break_glass_terraform_role_arn,
    module.tre_nonprod_terraform_roles.tre_break_glass_terraform_role_arn,
    module.tre_users_terraform_roles.tre_break_glass_terraform_role_arn,
    module.tre_management_terraform_roles.tre_break_glass_terraform_role_arn,
    module.tre_github_actions_open_id_connect.tre_github_actions_open_id_connect
  ]
}

