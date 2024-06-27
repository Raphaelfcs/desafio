
# Teste IAC

## Para analisar o código Python

Entre no diretório `python_scripts/`.

O arquivo `python_scripts/lambda_function.py` roda uma mensagem 'rodou a lambda pelo api gtw sucesso'. Para testar o código Python, use o comando dentro do diretório: 

```bash
python test_lambda.py
```

## Provisionamento da Infraestrutura

Para provisionar a infraestrutura de acordo com o desenho, preencha o `backend.tf` com o nome de um S3 existente. Esse S3 precisa ter o versionamento ativo, pois vai manter o estado da infraestrutura, que contém:

- **VPC**: Sub-redes, tabelas de roteamento e NAT Gateway.
- **Lambda**: Inclui um S3 que será criado em tempo de execução para armazenar o código Python e a própria Lambda privada em uma subnet com grupo de segurança.
- **API Gateway**: Contém chamadas de API públicas, chamando a Lambda privada.

## Executando o Código

Para criar sua infraestrutura, configure seu backend, exporte suas credenciais ou configure suas credenciais da AWS. Após isso, execute o arquivo:

```bash
create-iac.sh
```

## URL do API Gateway

Após a criação dos recursos, será informada a URL do API Gateway:

```
https://LINK-DO-API-GTW/prod/proxy
```

Para chamar a API, edite o arquivo removendo a penúltima `" na frente do `proxy` e rode o comando:

```bash
curl -X POST "https://LINK-DO-API-GTW/prod/proxy"
```

## Sucesso

SUCESSO: rodou a lambda pelo api gtw sucesso

# Informações de Código

## Terraform

```terraform
provider "aws" {
  region = local.region
}

data "aws_caller_identity" "current" {}

# Usando o módulo de VPC padrão da HashiCorp. Os valores são adicionados no arquivo locals.tf

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

# Módulo Próprio

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

# Módulo Próprio

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

# Arquivo locals.tf

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
```
