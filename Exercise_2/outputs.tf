# TODO: Define the output variable for the lambda function.
output "test_lambda" {
  value = aws_lambda_function.test_lambda.id
}
