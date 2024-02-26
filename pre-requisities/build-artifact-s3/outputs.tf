output "airbus-build-artifact-bucket" {
  value = aws_s3_bucket.airbus-build-artifact-bucket.bucket
  description = "The name of the s3 state bucket"
}
output "airbus-build-artifact-bucket-arn" {
  value = aws_s3_bucket.airbus-build-artifact-bucket.arn
  description = "The name of the s3 state bucket"
}
output "airbus-build-artifact-bucket-id" {
  value = aws_s3_bucket.airbus-build-artifact-bucket.id
  description = "The name of the s3 state bucket"
}