terraform {
  # Integration to AWS
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Provider setup
provider "aws" {
   region = "us-east-1"
}

# Lambda function setup
resource "aws_lambda_function" "lambda_function" {
   function_name = "SumFunctionTerraform"

   s3_bucket = "cloud-buzz-interview-s3"
   s3_key    = "v1.0.0/terraform-lambda.zip"

   handler = "lambda_function.handler"
   runtime = "python3.7"
   role = aws_iam_role.lambda_exec.arn

}

# IAM role which dictates what other AWS services the Lambda function
 # may access.
resource "aws_iam_role" "lambda_exec" {
   name = "serverless_example_lambda"
assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Give API gateway permissions to Lambda
resource "aws_lambda_permission" "apigw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.lambda_function.function_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   //source_arn = "${aws_api_gateway_rest_api.api-gateway.execution_arn}/*/*"
   source_arn = "${aws_apigatewayv2_api.http-gateway-terraform.execution_arn}"
}