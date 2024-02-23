output "s3-terraform-state-bucket" {
  value = aws_s3_bucket.terraform-state-bucket.bucket
  description = "The name of the s3 state bucket"
}