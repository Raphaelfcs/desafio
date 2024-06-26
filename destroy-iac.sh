#!/bin/bash

terraform_dir="$(pwd)"

cd $terraform_dir


echo "Iniciando Terraform e backend"

terraform init

echo "Formatando arquivos abaixo para padronização"

terraform fmt

echo "Teste de sintaxe terraform"

terraform validate

echo "Destruindo toda infra cirada por este modulo"

terraform destroy --auto-approve