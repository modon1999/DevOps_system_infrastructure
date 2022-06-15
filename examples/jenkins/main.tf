
provider "aws" {
  region = "eu-central-1"
}

module "vpc-default" {
  source = "../../modules/aws_network"
  env    = "example-jenkins"
  //  source               = "git@github.com:adv4000/terraform-modules.git//aws_network"
}

module "jenkins_default" {
  source      = "../../modules/jenkins"
  env         = "example-jenkins"
  vpc_id      = module.vpc-default.vpc_id
  subnet_id   = module.vpc-default.public_subnet_ids[0]
  name_bucket = "mgmt-bucket-20220411140556031800000001"
}

#===============================================
