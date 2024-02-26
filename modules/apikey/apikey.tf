resource "aws_api_gateway_api_key" "this" {
  name = var.name
  description = var.description
  enabled = var.enable_key
  tags = var.tags
}
resource "aws_api_gateway_usage_plan_key" "this" {
  key_id = aws_api_gateway_api_key.this.id
  key_type = "API_KEY"
  usage_plan_id = var.usage_plan_id
}