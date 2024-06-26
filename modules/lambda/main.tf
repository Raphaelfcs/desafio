resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "lambda_vpc_access_policy" {
  name        = "lambda_vpc_access_policy"
  description = "IAM policy for Lambda to access VPC"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_exec_policy" {
  name       = "lambda_exec_policy_attachment"
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy_attachment" "lambda_vpc_access_policy_attachment" {
  name       = "lambda_vpc_access_policy_attachment"
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = aws_iam_policy.lambda_vpc_access_policy.arn
}

resource "random_pet" "bucket_name" {
  length    = 2
  separator = "-"
}

resource "aws_s3_bucket" "lambda_code_bucket" {
  bucket = "lambda-code-bucket-${random_pet.bucket_name.id}"
}

resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_code_bucket.bucket
  key    = "lambda_function.zip"
  source = var.lambda_code_path
}

resource "aws_lambda_function" "lambda" {
  function_name = "private_lambda_function"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"
  runtime       = "python3.8"
  s3_bucket     = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key        = aws_s3_object.lambda_zip.key

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }

  environment {
    variables = {
      SUCCESS_MESSAGE = "Success: Lambda executed successfully!"
      FAILURE_MESSAGE = "Failure: Lambda execution failed!"
    }
  }
}

