#Informar o seu back end

terraform {
  backend "s3" {
    bucket  = "INFORME-O-NOME-DO-S3"
    encrypt = true /// É OBRIGATÓRIO O USO DE ENCRYPT
    key     = "diretorio/suaopcao/demo-teste.fstate"
    region  = "INFORME-SUA-REGIAO"
  }
}
