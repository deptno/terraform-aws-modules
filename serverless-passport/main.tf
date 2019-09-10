resource aws_dynamodb_table token {
  name = var.token-table-name
  hash_key = var.token-table-hash-key
  range_key = var.token-table-range-key
  billing_mode = "PAY_PER_REQUEST"

  ttl {
    attribute_name = var.token-table-ttl-key
  }

  attribute {
    name = var.token-table-hash-key
    type = "S"
  }
  attribute {
    name = var.token-table-range-key
    type = "S"
  }
}
