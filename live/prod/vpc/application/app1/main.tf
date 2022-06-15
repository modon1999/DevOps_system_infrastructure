#================== Provider ================

provider "aws" {
  region = "eu-central-1"
}

# =================== State ================

terraform {
  backend "s3" {
    # Поменяйте это на имя своего бакета!
    bucket = "modon-example-devops-project-state"
    key    = "prod/vpc/application/app1/terraform.tfstate"
    region = "eu-central-1"
    # Замените это именем своей таблицы DynamoDB!
    # dynamodb_table = "terraform-up-and-running-locks"
    # encrypt        = true
  }
}

#================== Data ================

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "modon-example-devops-project-state" // Bucket from where to GET Terraform State
    key    = "prod/network/terraform.tfstate"     // Object name in the bucket to GET Terraform state
    region = "eu-central-1"                       // Region where bycket created
  }
}

#================== Create eb app ================

module "elastic_beanstalk" {
  source              = "../../../../../modules/elastic_beanstalk"
  env                 = var.env
  arn_platform        = "arn:aws:elasticbeanstalk:eu-central-1::platform/PHP 8.0 running on 64bit Amazon Linux 2/3.3.11"
  vpc_id              = data.terraform_remote_state.network.outputs.prod_vpc_id
  application_subnets = data.terraform_remote_state.network.outputs.prod_private_subnet_ids
  common_tags = {
    Project = "Example DevOps"
  }
  environment_variables_map = {
    Project = "Example DevOps"
    env     = var.env
  }
}
