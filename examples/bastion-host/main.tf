provider "aws" {
  region = "eu-central-1"
}

#================ Modules ===============================

module "vpc-default" {
  source = "../../modules/aws_network"
  env    = "bastion-example"
}

module "basion_host" {
  source      = "../../modules/bastion-host"
  env         = "bastion-example"
  name_bucket = "dev-bucket--20220329083707223400000001"
  vpc_id      = module.vpc-default.vpc_id
  subnet_id   = module.vpc-default.public_subnet_ids[0]
  allow_ports = ["80", "443", "22"]
}

#===============================================
