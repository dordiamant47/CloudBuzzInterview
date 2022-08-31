resource "aws_apigatewayv2_api" "http-gateway-terraform" {
  name          = "http-gateway-terraform"
  protocol_type = "HTTP"

}

resource "aws_apigatewayv2_integration" "example2" {
  api_id                    = aws_apigatewayv2_api.http-gateway-terraform.id
  connection_type           = "INTERNET"
  content_handling_strategy = "CONVERT_TO_TEXT"
  description               = "Lambda example"
  integration_method        = "ANY"
  integration_type          = "HTTP_PROXY"
  integration_uri           = aws_lambda_function.lambda_function.arn
  passthrough_behavior      = "WHEN_NO_MATCH"
  payload_format_version    = "2.0"
}

resource "aws_apigatewayv2_authorizer" "example" {
  api_id           = aws_apigatewayv2_api.http-gateway-terraform.id
  authorizer_type  = "REQUEST"
  authorizer_credentials_arn = aws_iam_role.lambda_exec.arn
  authorizer_uri = aws_lambda_function.lambda_function.invoke_arn
  name             = "lambda-authorizer"
  identity_sources = ["$request.header.Authorization"]
  authorizer_payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "example2" {
  api_id    = aws_apigatewayv2_api.http-gateway-terraform.id
  route_key = "$default"
}

resource "aws_apigatewayv2_stage" "example2" {
  api_id = aws_apigatewayv2_api.http-gateway-terraform.id
  name   = "example-stage"
}