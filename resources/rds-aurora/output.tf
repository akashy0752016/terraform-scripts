output "rds_arn" {
  value = module.aurora_mysql.cluster_arn
  description = "The ARN for the created database"
}
output "rds_secret_arn" {
  description = "The secret key ARN used for database credentials"
  value = module.rds_secret_key.secretmanager_arn
}