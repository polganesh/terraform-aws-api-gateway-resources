# Description : Terraform module to create Api Gateway Integration resource on AWS.
resource "aws_api_gateway_integration" "default" {
  count                   = length(aws_api_gateway_method.default.*.id)
  rest_api_id             = data.aws_api_gateway_rest_api.rest_api.id

  resource_id             = aws_api_gateway_resource.default.*.id[count.index]
  http_method             = aws_api_gateway_method.default.*.http_method[count.index]
  integration_http_method = length(var.integration_http_method_types) > 0 ? element(var.integration_http_method_types, count.index) : "POST"
  type                    = length(var.integration_types) > 0 ? element(var.integration_types, count.index) : "AWS_PROXY"
  connection_type         = length(var.connection_types) > 0 ? element(var.connection_types, count.index) : "INTERNET"
  connection_id           = length(var.connection_ids) > 0 ? element(var.connection_ids, count.index) : ""
  uri                     = length(var.uri) > 0 ? element(var.uri, count.index) : ""
  credentials             = length(var.credentials_for_integration) > 0 ? element(var.credentials_for_integration, count.index) : ""
  request_parameters      = length(var.integration_request_parameters) > 0 ? element(var.integration_request_parameters, count.index) : {}
  request_templates       = length(var.integration_request_templates) > 0 ? element(var.integration_request_templates, count.index) : {}
  passthrough_behavior    = length(var.integration_passthrough_behaviors) > 0 ? element(var.integration_passthrough_behaviors, count.index) : null
  #cache_key_parameters    = length(var.cache_key_parameters) > 0 ? element(var.cache_key_parameters, count.index) : []
  #cache_namespace         = length(var.cache_namespaces) > 0 ? element(var.cache_namespaces, count.index) : ""
  #content_handling        = length(var.content_handlings) > 0 ? element(var.content_handlings, count.index) : null
  timeout_milliseconds    = length(var.timeout_milliseconds) > 0 ? element(var.timeout_milliseconds, count.index) : 29000
  depends_on              = [aws_api_gateway_method.default]
}

# Module      : Api Gateway Integration Response
# Description : Terraform module to create Api Gateway Integration Response resource on AWS for creating api.
resource "aws_api_gateway_integration_response" "default" {
  count       = length(aws_api_gateway_integration.default.*.id)
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.default.*.id[count.index]
  http_method = aws_api_gateway_method.default.*.http_method[count.index]
  status_code = aws_api_gateway_method_response.default.*.status_code[count.index]
  response_parameters = length(var.integration_response_parameters) > 0 ? element(var.integration_response_parameters, count.index) : {}
  response_templates  = length(var.response_templates) > 0 ? element(var.response_templates, count.index) : {}
  content_handling    = length(var.response_content_handlings) > 0 ? element(var.response_content_handlings, count.index) : null
}