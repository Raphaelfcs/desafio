output "api_gateway_url" {
  description = "The URL of the API Gateway"
  value       = aws_api_gateway_deployment.deployment.invoke_url
}

output "api_gateway_arn" {
  description = "The ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.api.execution_arn
}
