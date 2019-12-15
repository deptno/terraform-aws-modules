variable table_name {
	description = "table name"
	type = string
}
variable bucket_name {
	description = "content bucket"
	type = string
}
variable cdn_domain_name {
	description = "cdn domain name to serve upload content"
	type = string
}
variable zone_id {
	description = "route 53 aws_route53_zone.domain.zone_id"
	type = string
}
variable aws_acm_certificate {
	description = "arn: aws_acm_certificate"
	type = string
}
variable allowd_origins {
	description = "bucekt eg [\"*\"]"
	type = list(string)
}
