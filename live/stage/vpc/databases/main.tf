#================== Provider ================
provider "aws" {
  region = "eu-central-1"
}

#=============== State ===============

terraform {
  backend "s3" {
    # Поменяйте это на имя своего бакета!
    bucket = "modon-example-devops-project-state"
    key    = "stage/vpc/databases/terraform.tfstate"
    region = "eu-central-1"
    # Замените это именем своей таблицы DynamoDB!
    # dynamodb_table = "terraform-up-and-running-locks"
    # encrypt        = true
  }
}

#================== Data ================

data "terraform_remote_state" "password" {
  backend = "s3"
  config = {
    bucket = "modon-example-devops-project-state" // Bucket from where to GET Terraform State
    key    = "stage/kms/terraform.tfstate"        // Object name in the bucket to GET Terraform state
    region = "eu-central-1"                       // Region where bycket created
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "modon-example-devops-project-state" // Bucket from where to GET Terraform State
    key    = "stage/network/terraform.tfstate"    // Object name in the bucket to GET Terraform state
    region = "eu-central-1"                       // Region where bycket created
  }
}

#================== Modules ================

module "mysql" {
  source      = "../../../../modules/mysql/"
  name_db     = "stagedb"
  env         = "stage"
  type_db     = "db.t2.micro"
  storage     = 10
  username_db = "admin"
  password_db = data.terraform_remote_state.password.outputs.password_db_stage
  subnets_db  = data.terraform_remote_state.network.outputs.staging_private_subnet_ids
  common_tags = {
    Owner   = "Nikita Grigorev"
    Project = "Example DevOps"
  }
}
