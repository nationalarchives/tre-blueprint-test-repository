module "tre_github_actions_open_id_connect" {
  source = "./modules/open-id-connect"
  prefix = var.prefix
  #   tre_repositories = var.tre_repositories
  tre_github_actions_open_id_connect_policies = local.tre_github_actions_open_id_connect_policies
  account_id                                  = data.aws_caller_identity.management.account_id
  tre_github_actions_open_id_connect_roles    = local.tre_github_actions_open_id_connect_roles
}

# ----------------------------------------------------------

# TRE Environments Terraform Roles Modules
module "tre_management_terraform_roles" {
  source                            = "./modules/terraform-roles"
  external_id                       = var.external_id
  tre_open_id_connect_roles         = module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform
  tre_open_id_connect_platform_role = module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform
  prefix                            = var.prefix
  permission_boundary_policy_path   = "./templates/permission-boundary-policy/management.tftpl"
  terraform_policy_path             = "./templates/terraform-role-policy/management.tftpl"
  terraform_iam_policy_path         = "./templates/terraform-iam-policy/management.tftpl"
  tre_break_glass_terraform_policy  = data.aws_iam_policy_document.tre_break_glass_terraform.json
  account_id                        = data.aws_caller_identity.management.account_id
}

module "tre_users_terraform_roles" {
  source                            = "./modules/terraform-roles"
  external_id                       = var.external_id
  tre_open_id_connect_roles         = module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform
  tre_open_id_connect_platform_role = module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform
  prefix                            = var.prefix
  permission_boundary_policy_path   = "./templates/permission-boundary-policy/users.tftpl"
  terraform_policy_path             = "./templates/terraform-role-policy/users.tftpl"
  providers = {
    aws = aws.users
  }
  terraform_iam_policy_path        = "./templates/terraform-iam-policy/users.tftpl"
  tre_break_glass_terraform_policy = data.aws_iam_policy_document.tre_break_glass_terraform.json
  account_id                       = data.aws_caller_identity.users.account_id
}

module "tre_nonprod_terraform_roles" {
  source                            = "./modules/terraform-roles"
  external_id                       = var.external_id
  tre_open_id_connect_roles         = module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.nonprod
  tre_open_id_connect_platform_role = module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform
  prefix                            = var.prefix
  permission_boundary_policy_path   = "./templates/permission-boundary-policy/environments.tftpl"
  terraform_policy_path             = "./templates/terraform-role-policy/environments.tftpl"
  providers = {
    aws = aws.nonprod
  }
  terraform_iam_policy_path        = "./templates/terraform-iam-policy/environments.tftpl"
  tre_break_glass_terraform_policy = data.aws_iam_policy_document.tre_break_glass_terraform.json
  account_id                       = data.aws_caller_identity.nonprod.account_id
}

module "tre_prod_terraform_roles" {
  source                            = "./modules/terraform-roles"
  external_id                       = var.external_id
  tre_open_id_connect_roles         = module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.prod
  tre_open_id_connect_platform_role = module.tre_github_actions_open_id_connect.tre_open_id_connect_roles.platform
  prefix                            = var.prefix
  permission_boundary_policy_path   = "./templates/permission-boundary-policy/environments.tftpl"
  terraform_policy_path             = "./templates/terraform-role-policy/environments.tftpl"
  providers = {
    aws = aws.prod
  }
  terraform_iam_policy_path        = "./templates/terraform-iam-policy/environments.tftpl"
  tre_break_glass_terraform_policy = data.aws_iam_policy_document.tre_break_glass_terraform.json
  account_id                       = data.aws_caller_identity.prod.account_id
}
