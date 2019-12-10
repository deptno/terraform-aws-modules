variable domain {
	description = "domain name eg)tubemon.io"
	type = string
}
variable table_name {
	description = "domain name eg)tubemon.io"
	type = string
}
variable bucket_name {
	description = "domain name eg)tubemon.io"
	type = string
}
variable aws_acm_certificate {
	description = "arn: aws_acm_certificate"
	type = string
}
provider aws {
	region = "ap-northeast-2"
	profile = "yiguana"
}
provider aws {
	region = "us-east-1"
	profile = "yiguana"
	alias = "virginia"
}

locals {
	domain = "yiguana.dev.googit.co"
}

