variable "resource_tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "my-project"
  }
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "s3_object_key" {
  description = "The key for the uploaded lambda code"
  type        = string
}

variable "lambda_code_path" {
  description = "The local path to the lambda code"
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the Lambda function will be deployed"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}



/*


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
*/
