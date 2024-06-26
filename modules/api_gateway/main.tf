resource "aws_api_gateway_rest_api" "api" {
  name        = "minha-api-gateway"
  description = "API Gateway pública sem autenticação"
}

resource "aws_api_gateway_resource" "recurso" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "meu-recurso" # Defina o caminho do seu recurso
}

resource "aws_api_gateway_method" "metodo" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.recurso.id
  http_method   = "GET"  # Ou o método HTTP desejado (POST, PUT, etc.)
  authorization = "NONE" # Desabilita a autenticação
}


resource "aws_api_gateway_integration" "integracao_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.recurso.id
  http_method             = aws_api_gateway_method.metodo.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.minha_lambda.invoke_arn
}

resource "aws_lambda_permission" "api_gateway_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.minha_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}


resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [aws_api_gateway_integration.lambda]
  rest_api_id = aws_api_gateway_rest_api.api.id
  # Remova esta linha: stage_name  = "prod"

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_integration.lambda))
  }
}

resource "aws_api_gateway_stage" "prod" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.deployment.id  
  stage_name    = "prod"
}



