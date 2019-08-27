resource aws_api_gateway_base_path_mapping api {
  api_id      = var.aws_api_gateway_rest_api_id
  domain_name = aws_api_gateway_domain_name.api.domain_name
  stage_name  = var.stage
}
resource aws_api_gateway_domain_name api {
  domain_name     = var.domain
  certificate_arn = var.aws_acm_certificate_arn
}
resource aws_route53_record api {
  zone_id = var.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.api.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.api.cloudfront_zone_id
    evaluate_target_health = false
  }
}
resource aws_route53_record api-aaaa {
  zone_id = var.zone_id
  name    = var.domain
  type    = "AAAA"

  alias {
    name                   = aws_api_gateway_domain_name.api.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.api.cloudfront_zone_id
    evaluate_target_health = false
  }
}
