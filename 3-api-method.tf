resource "aws_api_gateway_method" "default" {
  count = length(var.path_parts)

  rest_api_id          = data.aws_api_gateway_rest_api.rest_api.id
  resource_id          = aws_api_gateway_resource.default.*.id[count.index]
  http_method          = element(var.http_method_types, count.index)
  authorization        = length(var.authorizations_for_http_methods) > 0 ? element(var.authorizations_for_http_methods, count.index) : "NONE"
  #authorizer_id        = length(var.authorizer_ids) > 0 ? element(var.authorizer_ids, count.index) : null
  #authorization_scopes = length(var.authorization_scopes) > 0 ? element(var.authorization_scopes, count.index) : null
  #api_key_required     = length(var.api_key_requireds) > 0 ? element(var.api_key_requireds, count.index) : null
  request_models       = length(var.request_models) > 0 ? element(var.request_models, count.index) : { "application/json" = "Empty" }
  #request_validator_id = length(var.request_validator_ids) > 0 ? element(var.request_validator_ids, count.index) : null
  request_parameters   = length(var.request_parameters) > 0 ? element(var.request_parameters, count.index) : {}
}

# Description : Terraform module to create Api Gateway Method Response resource on AWS.
resource "aws_api_gateway_method_response" "default" {
  count               = length(aws_api_gateway_method.default.*.id)
  rest_api_id         =  data.aws_api_gateway_rest_api.rest_api.id
  resource_id         = aws_api_gateway_resource.default.*.id[count.index]
  http_method         = aws_api_gateway_method.default.*.http_method[count.index]
  status_code         = element(var.response_status_codes, count.index)
  response_models     = length(var.response_models) > 0 ? element(var.response_models, count.index) : {}
  response_parameters = length(var.response_parameters) > 0 ? element(var.response_parameters, count.index) : {}
}