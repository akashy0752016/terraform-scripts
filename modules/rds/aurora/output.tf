output "cluster_arn" {
  description = "Amazon resource name (ARN) cluster"
  value = try(aws_rds_cluster.this[0].arn, "")
}
output "cluster_id" {
  description = "The RDS Cluster Identifier"
  value = try(aws_rds_cluster.this[0].id, "")
}
output "cluster_resource_id" {
  description = "The RDS Cluster Resource Id"
  value = try(aws_rds_cluster.this[0].cluster_resource_id, "")
}
output "cluster_member" {
  description = "List of RDS instances that are a part of this cluster"
  value = try(aws_rds_cluster.this[0].cluster_members, "")
}
output "cluster_endpoint" {
  description = "Writer endpoint for the cluster"
  value = try(aws_rds_cluster.this[0].endpoint, "")
}
output "cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value = try(aws_rds_cluster.this[0].reader_endpoint, "")
}
output "cluster_engine_version_actual" {
  description = "The running version of the cluster database"
  value = try(aws_rds_cluster.this[0].engine_version_actual, "")
}
output "cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value = var.database_name
}
output "cluster_port" {
  description = "The database port"
  value = try(aws_rds_cluster.this[0].port, "")
}
output "cluster_master_passowrd" {
  description = "The database master password"
  value = try(aws_rds_cluster.this[0].master_password, "")
}
output "cluster_master_username" {
  description = "The database master username"
  value = try(aws_rds_cluster.this[0].master_username, "")
}