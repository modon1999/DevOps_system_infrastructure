#----------------------------------------------------------
# My Terraform
#
# Use Our Terraform Module to create AWS VPC Networks
#
# Made by Nikita Grigorev. Spring 2022
#----------------------------------------------------------

# =================== Provider ================

provider "aws" {
  region = "eu-central-1"
}

# =================== State ================

terraform {
  backend "s3" {
    # Поменяйте это на имя своего бакета!
    bucket = "modon-example-devops-project-state"
    key    = "prod/network/terraform.tfstate"
    region = "eu-central-1"
    # Замените это именем своей таблицы DynamoDB!
    # dynamodb_table = "terraform-up-and-running-locks"
    # encrypt        = true
  }
}

# =================== VPC ================

module "vpc-prod" {
  source = "../../../modules/aws_network"
  // source               = "git@github.com:adv4000/terraform-modules.git//aws_network"
  env                  = "prod"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.22.0/24", "10.0.33.0/24"]
  custom_tags = {
    Project = "Example DevOps"
  }
}

#===============================================
