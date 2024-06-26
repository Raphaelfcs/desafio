provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

module "vpc" {
  source = "./modules/vpc"
}

module "lambda" {
  source                   = "./modules/lambda"
  vpc_id                   = module.vpc.vpc_id
  private_subnet_ids       = module.vpc.private_subnet_ids
  lambda_security_group_id = module.vpc.lambda_security_group_id
  lambda_code_path         = local.lambda_code_path
  api_gateway_rest_api_id  = module.api_gateway.api_id
  region                   = var.region
  account_id               = data.aws_caller_identity.current.account_id
}

module "api_gateway" {
  source              = "./modules/api_gateway"
  lambda_function_arn = module.lambda.lambda_function_arn
  region              = var.region
}



locals {
  lambda_code_path = "${path.module}/python_scripts/lambda_function.zip" # Substitua com o caminho correto
}
