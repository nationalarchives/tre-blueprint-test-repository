resource "aws_iam_role" "tre_terraform" {
  name               = "${var.prefix}-terraform"
  assume_role_policy = data.aws_iam_policy_document.tre_assume_role_terraform.json
}

resource "aws_iam_policy" "tre_terraform" {
  name = "${var.prefix}-terraform-policy"
  policy = templatefile(var.terraform_policy_path, {

  })
}

resource "aws_iam_role_policy_attachment" "tre_terraform" {
  role       = aws_iam_role.tre_terraform.name
  policy_arn = aws_iam_policy.tre_terraform.arn
}

resource "aws_iam_policy" "tre_terraform_iam" {
  name = "${var.prefix}-terraform-iam-policy"
  policy = templatefile(var.terraform_iam_policy_path, {
    tre_permission_boundary_policy_arn = aws_iam_policy.tre_permission_boundary.arn
    account_id                         = var.account_id
    prefix                             = var.prefix
  })
}

resource "aws_iam_role_policy_attachment" "tre_terraform_iam" {
  role       = aws_iam_role.tre_terraform.name
  policy_arn = aws_iam_policy.tre_terraform_iam.arn
}

resource "aws_iam_policy" "tre_permission_boundary" {
  name = "${var.prefix}-permission-boundary"
  policy = templatefile(var.permission_boundary_policy_path, {

  })
}
