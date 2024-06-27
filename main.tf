provider "aws" {
  region = local.region
}

data "aws_caller_identity" "current" {}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = local.vpc_configuration.name
  cidr                 = local.vpc_configuration.cidr
  azs                  = local.vpc_configuration.azs
  private_subnets      = local.vpc_configuration.private_subnets
  public_subnets       = local.vpc_configuration.public_subnets
  enable_dns_support   = local.vpc_configuration.enable_dns_support
  enable_dns_hostnames = local.vpc_configuration.enable_dns_hostnames
  enable_nat_gateway   = local.vpc_configuration.enable_nat_gateway
  single_nat_gateway   = local.vpc_configuration.single_nat_gateway
  tags                 = local.tags

}


module "private_lambda" {
  depends_on           = [module.vpc]
  source               = "./modules/lambda"
  vpc_id               = module.vpc.vpc_id
  s3_bucket_name       = local.private_lambda_configuration.s3_bucket_name
  s3_object_key        = local.private_lambda_configuration.s3_object_key
  lambda_code_path     = local.private_lambda_configuration.lambda_code_path
  lambda_function_name = local.private_lambda_configuration.lambda_function_name
  subnet_id            = module.vpc.private_subnets[0]
  resource_tags        = local.tags
}


module "api_gateway" {
  depends_on       = [module.private_lambda]
  source           = "./modules/api_gateway"
  api_gateway_name = local.api_gateway_configuration.api_gateway_name
  name_lambda      = module.private_lambda.function_name
  lambda_arn       = module.private_lambda.lambda_function_arn
  region           = local.region
  resource_tags    = local.tags
}


resource "random_string" "s3_suffix" {
  length  = 6
  special = false
  upper   = false
}
