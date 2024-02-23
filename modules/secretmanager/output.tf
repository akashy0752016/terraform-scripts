output "secretmanager_arn" {
  description = "Amazon Resource Name (ARN)"
  value = aws_secretsmanager_secret.secret_manager.arn
}