resource "aws_api_gateway_stage" "default" {
  count = var.api_log_enabled==false && var.deployment_enabled && var.stage_enabled && length(var.stage_names) > 0 ? length(var.stage_names) : 0

  rest_api_id           = data.aws_api_gateway_rest_api.rest_api.id
  deployment_id         = aws_api_gateway_deployment.default.*.id[0]
  stage_name            = element(var.stage_names, count.index)
  cache_cluster_enabled = length(var.stage_cache_cluster_enabled) > 0 ? element(var.stage_cache_cluster_enabled, count.index) : false
  cache_cluster_size    = length(var.stage_cache_cluster_sizes) > 0 ? element(var.stage_cache_cluster_sizes, count.index) : null
  description           = length(var.stage_descriptions) > 0 ? element(var.stage_descriptions, count.index) : ""
  documentation_version = length(var.stage_documentation_versions) > 0 ? element(var.stage_documentation_versions, count.index) : null
  variables             = length(var.stage_variables) > 0 ? element(var.stage_variables, count.index) : {}
  xray_tracing_enabled  = length(var.xray_tracing_enabled_for_stage) > 0 ? element(var.xray_tracing_enabled_for_stage, count.index) : false
}

resource "aws_api_gateway_stage" "stages_with_logs" {
  count = var.deployment_enabled && var.stage_enabled && var.api_log_enabled && length(var.stage_names) > 0 ? length(var.stage_names) : 0
  rest_api_id           = data.aws_api_gateway_rest_api.rest_api.id
  deployment_id         = aws_api_gateway_deployment.default.*.id[0]
  stage_name            = element(var.stage_names, count.index)
  cache_cluster_enabled = length(var.stage_cache_cluster_enabled) > 0 ? element(var.stage_cache_cluster_enabled, count.index) : false
  cache_cluster_size    = length(var.stage_cache_cluster_sizes) > 0 ? element(var.stage_cache_cluster_sizes, count.index) : null
  description           = length(var.stage_descriptions) > 0 ? element(var.stage_descriptions, count.index) : ""
  documentation_version = length(var.stage_documentation_versions) > 0 ? element(var.stage_documentation_versions, count.index) : null
  variables             = length(var.stage_variables) > 0 ? element(var.stage_variables, count.index) : {}
  xray_tracing_enabled  = length(var.xray_tracing_enabled_for_stage) > 0 ? element(var.xray_tracing_enabled_for_stage, count.index) : false
  access_log_settings {
    destination_arn= aws_cloudwatch_log_group.cw_Log_group_for_stage.*.arn[count.index]
    format=length(var.cw_log_group_format_for_stage) > 0 ? element(var.cw_log_group_format_for_stage, count.index) : "json"
  }
}

#more information at https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html
resource "aws_cloudwatch_log_group" "cw_Log_group_for_stage" {
    count = var.deployment_enabled && var.stage_enabled && var.api_log_enabled && length(var.stage_names) > 0 ? length(var.stage_names) : 0
    name= "cwlgrp/${var.rest_api_name}/${element(var.stage_names, count.index)}"
    retention_in_days=length(var.cw_log_stage_retention_in_days) > 0 ? element(var.cw_log_stage_retention_in_days, count.index) : "7"
}