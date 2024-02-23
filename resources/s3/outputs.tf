output "airbus-flat-file-storage-id" {
  value = aws_s3_bucket.airbus-flat-file-storage.id
  sensitive = false
}
output "airbus-flat-file-storage-arn" {
  value = aws_s3_bucket.airbus-flat-file-storage.arn
  sensitive = false
}