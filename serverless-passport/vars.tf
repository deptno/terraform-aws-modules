variable "token-table-name" {
  description = "dynamodb token table name"
  type = string
}
variable "token-table-hash-key" {
  description = "dynamodb token table hash key"
  type = string
}
variable "token-table-range-key" {
  description = "dynamodb token table range key"
  type = string
}
variable "token-table-ttl-key" {
  description = "dynamodb token table ttl key"
  type = string
}
