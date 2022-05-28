resource "aws_api_gateway_rest_api" "checkip" {
  name = "checkip"
}

resource "aws_api_gateway_method" "get_ip" {
  rest_api_id   = aws_api_gateway_rest_api.checkip.id
  resource_id   = aws_api_gateway_rest_api.checkip.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}
