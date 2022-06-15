#----------------------------------------------------------
# My Terraform
#
# Use Our Terraform Module to create AWS VPC Networks
#
# Made by Denis Astahov. Summer 2019
#----------------------------------------------------------
provider "aws" {
  region = "eu-central-1"
}

module "vpc-default" {
  source = "../../modules/aws_network"
  env    = "example"
  //  source               = "git@github.com:adv4000/terraform-modules.git//aws_network"
}

module "security_group_default" {
  source = "../../modules/aws_security_group"
  vpc_id = module.vpc-default.vpc_id
  env    = "example"
}

module "key_instance" {
  source   = "../../modules/key_instance/"
  name_key = "example"
}


module "server_default" {
  source                 = "../../modules/aws_instance"
  env                    = "example"
  subnet_id              = module.vpc-default.public_subnet_ids[0]
  key_name               = module.key_instance.name_key
  vpc_security_group_ids = [module.security_group_default.security_group_id]
  user_data              = file("user_data.sh")
  iam_instance_profile   = file("policy_example.json")
}

#===============================================
