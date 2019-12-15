output dynamodb {
	value = aws_dynamodb_table.yiguana.name
}
output s3_bucket {
	value = aws_s3_bucket.yiguana.bucket
}
output cdn_domain {
	value = aws_route53_record.cdn.name
}
output cloudfront_frontend_id {
	value = aws_cloudfront_distribution.yiguana.id
}
