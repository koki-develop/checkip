resource "aws_api_gateway_rest_api" "checkip" {
  name = "checkip"
}

resource "aws_api_gateway_method" "get_ip" {
  rest_api_id   = aws_api_gateway_rest_api.checkip.id
  resource_id   = aws_api_gateway_rest_api.checkip.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_ip" {
  rest_api_id          = aws_api_gateway_rest_api.checkip.id
  resource_id          = aws_api_gateway_rest_api.checkip.root_resource_id
  http_method          = aws_api_gateway_method.get_ip.http_method
  type                 = "MOCK"
  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" : jsonencode({ statusCode : 200 })
  }
}

resource "aws_api_gateway_method_response" "get_ip_200" {
  rest_api_id = aws_api_gateway_rest_api.checkip.id
  resource_id = aws_api_gateway_rest_api.checkip.root_resource_id
  http_method = aws_api_gateway_method.get_ip.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "get_ip_200" {
  rest_api_id = aws_api_gateway_rest_api.checkip.id
  resource_id = aws_api_gateway_rest_api.checkip.root_resource_id
  http_method = aws_api_gateway_method.get_ip.http_method
  status_code = aws_api_gateway_method_response.get_ip_200.status_code

  response_templates = {
    "application/json" = "test"
  }
}

resource "aws_api_gateway_deployment" "checkip" {
  rest_api_id = aws_api_gateway_rest_api.checkip.id
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "checkip" {
  rest_api_id   = aws_api_gateway_rest_api.checkip.id
  deployment_id = aws_api_gateway_deployment.checkip.id
  stage_name    = "prod"
}
