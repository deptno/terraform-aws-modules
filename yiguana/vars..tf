variable region {
	description = "aws region"
	type = string
	default = "ap-northeast-2"
}
variable profile {
	description = "aws profile"
	type = string
	default = "default"
}

variable table_name {
	description = "table name"
	type = string
}
variable bucket_name {
	description = "content bucket"
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
