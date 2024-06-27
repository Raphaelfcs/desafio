variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "lambda_arn" {
  description = "The ARN of the Lambda function to be invoked by the API Gateway"
  type        = string
}

variable "region" {
  description = "The AWS region where the resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "resource_tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "my-project"
  }
}

variable "name_lambda" {
  type = string
}