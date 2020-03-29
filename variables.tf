variable "aws_resource_depends_on" {
  type    = any
  default = null
  description="list of aws resources to be created before creating aws_api_gateway_resource"
}

variable "rest_api_name" {
  default = ""
}

variable "resource_parent_id"{
  type        = list
  default     = []
  description = "if you want to attach it to root resource then provide empty string else for path based thing provide id. for more information refer readme of this module."
}

variable "path_parts" {
  type        = list
  default     = []
  description = "The last path segment of this API resource."
}

variable "model_names" {
  type        = list
  default     = []
  description = "The name of the model."
}

variable "model_descriptions" {
  type        = list
  default     = []
  description = "The description of the model."
}

variable "model_content_types" {
  type        = list
  default     = []
  description = "The content type of the model."
}

variable "http_method_types" {
  type        = list
  default     = []
  description = "The HTTP Method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY)."
}

variable "authorizations_for_http_methods" {
  type        = list
  default     = []
  description = "The type of authorization used for the method (NONE, CUSTOM, AWS_IAM, COGNITO_USER_POOLS)."
}

variable "request_models" {
  type        = list
  default     = []
  description = "A map of the API models used for the request's content type where key is the content type (e.g. application/json) and value is either Error, Empty (built-in models) or aws_api_gateway_model's name."
}

variable "request_parameters" {
  type        = list
  default     = []
  description = "A map of request query string parameters and headers that should be passed to the integration. For example: request_parameters = {\"method.request.header.X-Some-Header\" = true \"method.request.querystring.some-query-param\" = true} would define that the header X-Some-Header and the query string some-query-param must be provided in the request."
}

variable "integration_http_method_types" {
  type        = list
  default     = []
  description = "The integration HTTP method (GET, POST, PUT, DELETE, HEAD, OPTIONs, ANY, PATCH) specifying how API Gateway will interact with the back end. Required if type is AWS, AWS_PROXY, HTTP or HTTP_PROXY. Not all methods are compatible with all AWS integrations. e.g. Lambda function can only be invoked via POST."
}

variable "integration_types" {
  type        = list
  default     = []
  description = "The integration input's type. Valid values are   HTTP (for HTTP backends), MOCK (not calling any real backend), AWS (for AWS services), AWS_PROXY (for Lambda proxy integration) and HTTP_PROXY (for HTTP proxy integration). An HTTP or HTTP_PROXY integration with a connection_type of VPC_LINK is referred to as a private integration and uses a VpcLink to connect API Gateway to a network load balancer of a VPC."
}

variable "connection_types" {
  type        = list
  default     = []
  description = "The integration input's connectionType. Valid values are INTERNET (default for connections through the public routable internet), and VPC_LINK (for private connections between API Gateway and a network load balancer in a VPC)."
}

variable "connection_ids" {
  type        = list
  default     = []
  description = "The id of the VpcLink used for the integration. Required if connection_type is VPC_LINK."
}

variable "uri" {
  type        = list
  default     = []
  description = "The input's URI. Required if type is AWS, AWS_PROXY, HTTP or HTTP_PROXY. For HTTP integrations, the URI must be a fully formed, encoded HTTP(S) URL according to the RFC-3986 specification . For AWS integrations, the URI should be of the form arn:aws:apigateway:{region}:{subdomain.service|service}:{path|action}/{service_api}. region, subdomain and service are used to determine the right endpoint. e.g. arn:aws:apigateway:eu-west-1:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-1:012345678901:function:my-func/invocations."
}

variable "credentials_for_integration" {
  type        = list
  default     = []
  description = "The credentials required for the integration. For AWS integrations, 2 options are available. To specify an IAM Role for Amazon API Gateway to assume, use the role's ARN. To require that the caller's identity be passed through from the request, specify the string arn:aws:iam::*:user/*."
}

variable "integration_request_parameters" {
  type        = list
  default     = []
  description = "A map of request query string parameters and headers that should be passed to the backend responder. For example: request_parameters = { \"integration.request.header.X-Some-Other-Header\" = \"method.request.header.X-Some-Header\" }."
}

variable "integration_request_templates" {
  type        = list
  default     = []
  description = "A map of the integration's request templates."
}

variable "integration_passthrough_behaviors"{
  type        = list
  default     = []
}

variable "timeout_milliseconds" {
   type        = list
  default     = []
}


variable "response_status_codes"{
  type        = list
  default     = []
  description = "The HTTP status code."
}

variable "response_models" {
  type        = list
  default     = []
  description = "A map of the API models used for the response's content type."
}

variable "response_parameters" {
  type        = list
  default     = []
  description = "A map of response parameters that can be sent to the caller. For example: response_parameters = { \"method.response.header.X-Some-Header\" = true } would define that the header X-Some-Header can be provided on the response."
}

variable "integration_response_parameters" {
  type        = list
  default     = []
  description = "A map of response parameters that can be read from the backend response. For example: response_parameters = { \"method.response.header.X-Some-Header\" = \"integration.response.header.X-Some-Other-Header\" }."
}

variable "response_templates" {
  type        = list
  default     = []
  description = "A map specifying the templates used to transform the integration response body."
}

variable "response_content_handlings" {
  type        = list
  default     = []
  description = "Specifies how to handle request payload content type conversions. Supported values are CONVERT_TO_BINARY and CONVERT_TO_TEXT. If this property is not defined, the response payload will be passed through from the integration response to the method response without modification."
}

variable "deployment_enabled" {
  type        = bool
  default     = false
  description = "is  deploy to rest api."
}

variable "new_stage_name_to_deploy" {
  type        = string
  default     = ""
  description = "The name of the stage. If the specified stage already exists, it will be updated to point to the new deployment. If the stage does not exist, a new one will be created and point to this deployment."
}

variable "deployment_description" {
  type        = string
  default     = ""
  description = "The description of the deployment."
}

variable "stage_description_to_be_deployed" {
  type        = string
  default     = ""
  description = "The description of the deployment."
}

variable "stage_variables_to_be_deployed" {
  type        = map
  default     = {}
  description = "A map that defines variables for the stage to be deployed"
}

variable "stage_enabled" {
  type        = bool
  default     = false
  description = "Whether to create stage for rest api."
}

variable "stage_names" {
  type        = list
  default     = []
  description = "The name of the stage."
}

variable "stage_cache_cluster_enabled" {
  type        = list
  default     = []
  description = "Specifies whether a cache cluster is enabled for the stage."
}

variable "stage_cache_cluster_sizes" {
  type        = list
  default     = []
  description = "The size of the cache cluster for the stage, if enabled. Allowed values include 0.5, 1.6, 6.1, 13.5, 28.4, 58.2, 118 and 237."
}

variable "stage_descriptions"{
   type        = list
  default     = []
  description = "The description of the stage."
}

variable "stage_documentation_versions"{
  type        = list
  default     = []
  description = "The version of the associated API documentation."
}

variable "stage_variables"{
  type        = list
  default     = []
  description = "A map that defines the stage variables."
}

variable "xray_tracing_enabled_for_stage"{
  type        = list
  default     = []
  description = "is xray tracing to be enabled for stage"
}


variable "api_log_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable log for rest api."
}

variable "cw_log_stage_retention_in_days"{
type        = list
  default     = []
  description = "retention days for cloud watch logs"
}

variable "cw_log_group_format_for_stage"{
type        = list
  default     = []
  description = "format for cloud watch log for stage. possible values CLF,JSON,XML,CSV"
}



