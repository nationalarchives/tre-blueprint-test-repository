# resource "aws_lambda_function" "tre_bp_test" {
#   function_name = "${var.prefix}-${var.env}-test-lambda"
#   package_type = "Image"
#   image_uri = ""
#   role = aws_iam_role.tre_bp_test_lambda.arn
# }

# resource "aws_iam_role" "tre_bp_test_lambda" {
#   name = "${var.prefix}-${var.env}-test-lambda-role"
#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
# }

# data "aws_iam_policy_document" "lambda_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["lambda.amazonaws.com"]
#     }
#   }
# }
