provider "aws" {
  access_key = "insert_env_var_here"
  secret_key = "insert_env_var_here"
  region     = var.aws_region
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

terraform {
  required_providers {
    aws     = "~> 2.68"
    archive = "~> 1.3"
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "sample_function" {
  filename      = var.output_archive_name
  function_name = "sample_function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "greet_lambda.lambda_handler"
  depends_on    = [aws_iam_role_policy_attachment.lambda_logging]
  runtime       = "python3.7"

  environment {
    variables = {
      greeting = "Hey there!"
    }
  }
  memory_size = 128
  timeout     = 30
}

data "archive_file" "sample_function" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = var.output_archive_name
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "sample_function" {
  name              = "sample_function"
  retention_in_days = "90"
}

resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}
