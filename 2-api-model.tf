resource "aws_api_gateway_model" "default" {
  count        = length(var.model_names)
  rest_api_id  = data.aws_api_gateway_rest_api.rest_api.id
  name         = element(var.model_names, count.index)
  description  = length(var.model_descriptions) > 0 ? element(var.model_descriptions, count.index) : ""
  content_type = element(var.model_content_types, count.index)
  schema = <<EOF
    {"type":"object"}
    EOF
}

