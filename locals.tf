locals {

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  region = "us-east-1"

  vpc_configuration = {
    name                 = "my-vpc"
    cidr                 = "10.0.0.0/16"
    azs                  = ["us-east-1a", "us-east-1b"]
    private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets       = ["10.0.101.0/24", "10.0.102.0/24"]
    enable_dns_support   = true
    enable_dns_hostnames = true
    single_nat_gateway   = false
    enable_nat_gateway   = true
  }

  private_lambda_configuration = {

    s3_bucket_name       = "my-unique-lambda-bucket-${random_string.s3_suffix.result}"
    s3_object_key        = "lambda_code.zip"
    lambda_function_name = "my_private_lambda"
    lambda_code_path     = "${path.module}/python_scripts/lambda_function.zip"
  }


  api_gateway_configuration = {
    api_gateway_name = "ph-teste-demo"

  }



}