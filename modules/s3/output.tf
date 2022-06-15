output "name_bucket" {
  value       = aws_s3_bucket.bucket.id
  description = "Name bucket"
}

output "arn_bucket" {
  value       = aws_s3_bucket.bucket.arn
  description = "Arn bucket"
}
