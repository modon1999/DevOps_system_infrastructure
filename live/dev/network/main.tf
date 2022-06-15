#----------------------------------------------------------
# My Terraform
#
# Use Our Terraform Module to create AWS VPC Networks
#
# Made by Nikita Grigorev. Summer 2022
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
    key    = "dev/network/terraform.tfstate"
    region = "eu-central-1"
    # Замените это именем своей таблицы DynamoDB!
    # dynamodb_table = "terraform-up-and-running-locks"
    # encrypt        = true
  }
}

# =================== VPC ================

module "vpc-dev" {
  source = "../../../modules/aws_network"
  //  source               = "git@github.com:adv4000/terraform-modules.git//aws_network"
  env                  = "dev"
  vpc_cidr             = "10.20.0.0/16"
  public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
  private_subnet_cidrs = []
  custom_tags = {
    Project = "Example DevOps"
  }
}

#===============================================
