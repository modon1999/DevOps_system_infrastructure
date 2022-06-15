output "name_bucket" {
  value       = module.s3_bucket.name_bucket
  description = "Name bucket"
}

output "arn_bucket" {
  value       = module.s3_bucket.arn_bucket
  description = "Arn bucket"
}

output "website_endpoint" {
  value       = module.s3_bucket.website_endpoint
  description = "Domain website"
  # depends_on  = [aws_s3_bucket_website_configuration.website]
}
