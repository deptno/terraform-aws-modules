output dynamodb {
	value = aws_dynamodb_table.yiguana.name
}
output s3 {
	value = aws_s3_bucket.yiguana.bucket
}
output cloudfront_frontend {
	value = aws_cloudfront_distribution.yiguana.id
}
