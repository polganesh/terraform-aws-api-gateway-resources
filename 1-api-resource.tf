resource "aws_api_gateway_resource" "default" {
  count = length(var.path_parts)
  rest_api_id = data.aws_api_gateway_rest_api.rest_api.id
  parent_id = element(var.resource_parent_id, count.index) != "" ? element(var.resource_parent_id, count.index) : data.aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = element(var.path_parts, count.index)
  depends_on  = [var.aws_resource_depends_on]
  #tags to be added
}


