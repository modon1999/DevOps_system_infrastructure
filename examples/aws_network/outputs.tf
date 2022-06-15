
output "prod_public_subnet_ids" {
  value = module.vpc-default.public_subnet_ids
}

output "prod_private_subnet_ids" {
  value = module.vpc-default.private_subnet_ids
}

output "dev_public_subnet_ids" {
  value = module.vpc-default.public_subnet_ids
}

output "dev_private_subnet_ids" {
  value = module.vpc-default.private_subnet_ids
}
