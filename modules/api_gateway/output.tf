output "api_url" {
  value = "https://${aws_api_gateway_rest_api.api.id}.execute-api.${var.region}.amazonaws.com/prod"
}

output "api_id" {
  value = aws_api_gateway_rest_api.api.id
}
