resource "aws_secretsmanager_secret" "secret_manager" {
  name = var.name
  description = var.description
  kms_key_id = var.kms_key
  tags = var.tags
}
resource "aws_secretsmanager_secret_version" "secret_manager_version" {
  secret_id = aws_secretsmanager_secret.secret_manager.id
  secret_string = jsondecode(var.credentials)
}