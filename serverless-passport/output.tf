output "dynamodb_token_table" {
  value = aws_dynamodb_table.token.name
}
