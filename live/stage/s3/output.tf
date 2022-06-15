output "name_bucket" {
  value       = module.stage_s3_bucket.name_bucket
  description = "Name bucket"
}

output "arn_bucket" {
  value       = module.stage_s3_bucket.arn_bucket
  description = "Arn bucket"
}
