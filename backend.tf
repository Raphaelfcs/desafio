/*terraform {
  backend "s3" {
    bucket  = "INFORME-O-NOME-DO-S3-ONDE-FICARA-O-ESTADO-DA-INFRA"
    encrypt = true /// É OBRIGATÓRIO O USO DE ENCRYPT
    key     = "iac-unimed/INFORME-O-NOME-DO-PROJETO/INFORME-O-AMBIENTE/INFORME-O-NOME-DO-SATE.tfstate"
    region  = "INFORME-SUA-REGIAO"
  }
}
*/

terraform {
  backend "s3" {
    bucket  = "poc-rapha-aws-iac"
    encrypt = true /// É OBRIGATÓRIO O USO DE ENCRYPT
    key     = "iac-poc/demo/SANDBOX/DEMO-TESTE.tfstate"
    region  = "us-east-1"
  }
}