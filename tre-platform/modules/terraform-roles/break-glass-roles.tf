resource "aws_iam_role" "tre_break_glass_terraform" {
  name               = "${var.prefix}-break-glasss-terraform"
  assume_role_policy = data.aws_iam_policy_document.tre_assume_role_break_glass.json
}

resource "aws_iam_policy" "tre_break_glass_terraform" {
  name   = "${var.prefix}-break-glass-terraform"
  policy = var.tre_break_glass_terraform_policy
}

resource "aws_iam_role_policy_attachment" "tre_break_glass_terraform" {
  role       = aws_iam_role.tre_break_glass_terraform.name
  policy_arn = aws_iam_policy.tre_break_glass_terraform.arn
}
