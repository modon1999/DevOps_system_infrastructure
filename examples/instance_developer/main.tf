provider "aws" {
  region = "eu-central-1"
}

#================ Modules ===============================

module "vpc-default" {
  source = "../../modules/aws_network"
  env    = "dev-example"
}

module "server_dev" {
  source      = "../../modules/instance_developer"
  env         = "dev-example"
  name_bucket = "dev-bucket--20220329083707223400000001"
  owner       = "Nikita Grigorev"
  vpc_id      = module.vpc-default.vpc_id
  subnet_id   = module.vpc-default.public_subnet_ids[0]
  allow_ports = ["80", "443", "22"]
}

#===============================================
