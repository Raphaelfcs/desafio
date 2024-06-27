output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.private_lambda.arn
}

output "function_name" {
  
   description = "The ARN of the Lambda function"
   value       = aws_lambda_function.private_lambda.function_name
}