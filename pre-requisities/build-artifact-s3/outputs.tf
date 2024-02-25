output "build-arifact-bucket" {
  value = aws_s3_bucket.build-arifact-bucket.bucket
  description = "The name of the s3 state bucket"
}
output "build-arifact-bucket-arn" {
  value = aws_s3_bucket.build-arifact-bucket.arn
  description = "The name of the s3 state bucket"
}
output "build-arifact-bucket-id" {
  value = aws_s3_bucket.build-arifact-bucket.id
  description = "The name of the s3 state bucket"
}