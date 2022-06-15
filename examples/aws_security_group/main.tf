#----------------------------------------------------------
# My Terraform
#
# Use Our Terraform Module to create AWS VPC Networks
#
# Made by Denis Astahov. Summer 2019
#----------------------------------------------------------
provider "aws" {
  region = var.region
}

module "vpc-default" {
  source = "../../modules/aws_network"
  //  source               = "git@github.com:adv4000/terraform-modules.git//aws_network"
}

module "security_group_default" {
  source = "../../modules/aws_security_group"
  vpc_id = module.vpc-default.vpc_id
}

#===============================================
