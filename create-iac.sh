#!/bin/bash

terraform_dir="$(pwd)"

cd $terraform_dir

echo "Iniciando Terraform e backend"

terraform init

echo "Formatando arquivos abaixo para padronização"

terraform fmt

echo "Teste de sintaxe terraform"

terraform validate

echo "Criaando plano de terraform"

terraform plan -out plan

echo "APlicando plano"

terraform apply plan