output "key_id" {
  value = aws_api_gateway_api_key.this.id
}
output "key_name" {
  value = aws_api_gateway_api_key.this.name
}