output "staging_vpc_id" {
  value = module.vpc-staging.vpc_id
}

output "staging_public_subnet_ids" {
  value = module.vpc-staging.public_subnet_ids
}

output "staging_private_subnet_ids" {
  value = module.vpc-staging.private_subnet_ids
}
