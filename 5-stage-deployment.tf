# Module      : Api Gateway Deployment
# Description : Terraform module to create Api Gateway Deployment resource on AWS.
resource "aws_api_gateway_deployment" "default" {
  count = var.deployment_enabled ? 1 : 0
  rest_api_id       = data.aws_api_gateway_rest_api.rest_api.id
  stage_name        = var.new_stage_name_to_deploy
  description       = var.deployment_description
  stage_description = var.stage_description_to_be_deployed
  variables         = var.stage_variables_to_be_deployed
  depends_on        = [aws_api_gateway_method.default, aws_api_gateway_integration.default]
}