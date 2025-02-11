resource aws_dynamodb_table yiguana {
  name         = var.table_name
  hash_key     = "hk"
  range_key    = "rk"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "hk"
    type = "S"
  }
  attribute {
    name = "rk"
    type = "S"
  }
  attribute {
    name = "postId"
    type = "S"
  }
  attribute {
    name = "userId"
    type = "S"
  }
  attribute {
    name = "category"
    type = "S"
  }
  attribute {
    name = "byUser"
    type = "S"
  }
  attribute {
    name = "comments"
    type = "S"
  }
  attribute {
    name = "posts"
    type = "S"
  }
  attribute {
    name = "agg"
    type = "S"
  }
  attribute {
    name = "reports"
    type = "S"
  }
  attribute {
    name = "reportsEnd"
    type = "S"
  }

  global_secondary_index {
    name            = "byUser"
    hash_key        = "userId"
    range_key       = "byUser"
    projection_type = "ALL"
  }
  global_secondary_index {
    name            = "posts"
    hash_key        = "rk"
    range_key       = "posts"
    projection_type = "ALL"
  }
  global_secondary_index {
    name            = "postsByCategory"
    hash_key        = "rk"
    range_key       = "category"
    projection_type = "ALL"
  }
  global_secondary_index {
    name            = "comments"
    hash_key        = "postId"
    range_key       = "comments"
    projection_type = "ALL"
  }
  global_secondary_index {
    name            = "reports"
    hash_key        = "agg"
    range_key       = "reports"
    projection_type = "ALL"
  }
  global_secondary_index {
    name            = "reportsEnd"
    hash_key        = "agg"
    range_key       = "reportsEnd"
    projection_type = "ALL"
  }
}
resource aws_s3_bucket yiguana {
  bucket = var.bucket_name
  acl    = "private"

  cors_rule {
    allowed_methods = [
      "POST",
      "GET"
    ]
    allowed_origins = var.allowd_origins
    max_age_seconds = 86400
  }
}
data aws_iam_policy_document s3_policy {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.yiguana.arn}/*"]
    
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
  
  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.yiguana.arn]
    
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}
resource aws_s3_bucket_policy s3_policy {
  bucket = aws_s3_bucket.yiguana.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
resource aws_cloudfront_origin_access_identity origin_access_identity {
  comment = "yiguana ${var.bucket_name}"
}
resource aws_cloudfront_distribution yiguana {
  origin {
    domain_name = aws_s3_bucket.yiguana.bucket_domain_name
    origin_id   = aws_s3_bucket.yiguana.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }
	

  enabled             = true
  is_ipv6_enabled     = true
  comment             = aws_s3_bucket.yiguana.id
  wait_for_deployment = false

  aliases = [
    var.cdn_domain_name
  ]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.yiguana.id
    compress         = true

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    default_ttl            = 86400
    min_ttl                = 600
    max_ttl                = 31536000
  }
  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code            = 403
    error_caching_min_ttl = 0
    response_page_path    = "/index.html"
    response_code         = 200
  }
  custom_error_response {
    error_code            = 404
    error_caching_min_ttl = 0
    response_page_path    = "/index.html"
    response_code         = 404
  }
  custom_error_response {
    error_code            = 502
    error_caching_min_ttl = 10
  }
  custom_error_response {
    error_code            = 503
    error_caching_min_ttl = 10
  }

  viewer_certificate {
    acm_certificate_arn      = var.aws_acm_certificate
    minimum_protocol_version = "TLSv1.1_2016"
    ssl_support_method       = "sni-only"
  }
}
resource aws_route53_record cdn {
  zone_id = var.zone_id
  name    = var.cdn_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.yiguana.domain_name
    zone_id                = aws_cloudfront_distribution.yiguana.hosted_zone_id
    evaluate_target_health = false
  }
}
resource aws_route53_record cdn-aaaa {
  zone_id = var.zone_id
  name    = var.cdn_domain_name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.yiguana.domain_name
    zone_id                = aws_cloudfront_distribution.yiguana.hosted_zone_id
    evaluate_target_health = false
  }
}

