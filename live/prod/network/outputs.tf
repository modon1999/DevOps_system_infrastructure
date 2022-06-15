output "prod_vpc_id" {
  value = module.vpc-prod.vpc_id
}

output "prod_public_subnet_ids" {
  value = module.vpc-prod.public_subnet_ids
}

output "prod_private_subnet_ids" {
  value = module.vpc-prod.private_subnet_ids
}
