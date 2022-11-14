# LambdaFunction

resource "aws_lambda_function" "tre_bp_poc" {
  function_name = "${var.prefix}-${var.env}-poc-lambda"
  package_type = "Image"
  image_uri = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/tre-v2/poc-lambda:0.1.16"
  role = aws_iam_role.tre_bp_poc_lambda.arn
}

resource "aws_iam_role" "tre_bp_poc_lambda" {
  name = "${var.prefix}-${var.env}-poc-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# StepFunction

resource "aws_sfn_state_machine" "tre_bp_poc" {
  name     = "${var.prefix}-${var.env}-poc-step-function"
  role_arn = aws_iam_role.tre_bp_poc_step_function.arn
  definition = templatefile("${path.module}/templates/step-function-definition.json.tftpl", {
    arn_lambda_poc_lambda = aws_lambda_function.tre_bp_poc.arn
  })
}

resource "aws_iam_role" "tre_bp_poc_step_function" {
  name = "${var.prefix}-${var.env}-poc-step-function-role"
  assume_role_policy = data.aws_iam_policy_document.tre_bp_poc_assume_role_policy.json
  inline_policy {
    name = "${var.prefix}-${var.env}-lambda-invoke"
    policy = data.aws_iam_policy_document.tre_bp_poc_lambda_invoke_polciy.json
  }
}

data "aws_iam_policy_document" "tre_bp_poc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "tre_bp_poc_lambda_invoke_polciy" {
    statement {
    sid     = "InvokeLambdaPolicy"
    effect  = "Allow"
    actions = ["lambda:InvokeFunction"]
    resources = [
      aws_lambda_function.tre_bp_poc.arn
    ]
  }

}

data "aws_caller_identity" "current" {

}

data "aws_region" "current" {
  
}