variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "lambda_security_group_id" {
  description = "Security group ID for the Lambda function"
  type        = string
}

variable "lambda_code_path" {
  description = "Path to the lambda function zip file"
  type        = string
}

variable "api_gateway_rest_api_id" {
  description = "ID of the API Gateway REST API"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}
