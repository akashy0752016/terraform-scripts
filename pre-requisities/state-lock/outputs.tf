output "lock-table" {
  value = aws_dynamodb_table.terraform-state-lock.name
  description = "The state lock table"
}