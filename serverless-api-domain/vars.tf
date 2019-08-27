variable "aws_api_gateway_rest_api_id" {
  description = "aws_api_gateway_api id of deployed serverless service"
  type = "string"
}
variable "zone_id" {
  description = "domain zone id"
  type = "string"
}
variable "aws_acm_certificate_arn" {
  description = "arn of ACM"
  type = "string"
}

variable "stage" {
  description = "api gateway stage"
  type = "string"
}
variable "domain" {
  description = "arn of ACM"
  type = "string"
}
