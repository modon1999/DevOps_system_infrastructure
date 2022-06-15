#=============== Provider ===============

provider "aws" {
  region = "eu-central-1"
}

#=============== State ===============

terraform {
  backend "s3" {
    # Поменяйте это на имя своего бакета!
    bucket = "modon-example-devops-project-state"
    key    = "dev/vpc/dev_workspace/dev2/terraform.tfstate"
    region = "eu-central-1"
    # Замените это именем своей таблицы DynamoDB!
    # dynamodb_table = "terraform-up-and-running-locks"
    # encrypt        = true
  }
}

#================== Data ================

data "terraform_remote_state" "bucket" {
  backend = "s3"
  config = {
    bucket = "modon-example-devops-project-state" // Bucket from where to GET Terraform State
    key    = "dev/s3/terraform.tfstate"           // Object name in the bucket to GET Terraform state
    region = "eu-central-1"                       // Region where bycket created
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "modon-example-devops-project-state" // Bucket from where to GET Terraform State
    key    = "dev/network/terraform.tfstate"      // Object name in the bucket to GET Terraform state
    region = "eu-central-1"                       // Region where bycket created
  }
}

data "terraform_remote_state" "database" {
  backend = "s3"
  config = {
    bucket = "modon-example-devops-project-state"  // Bucket from where to GET Terraform State
    key    = "dev/vpc/databases/terraform.tfstate" // Object name in the bucket to GET Terraform state
    region = "eu-central-1"                        // Region where bycket created
  }
}

#================ Modules ===============================

module "server_dev" {
  source      = "../../../../../modules/instance_developer"
  env         = "dev"
  name        = "developer-2"
  db_address  = data.terraform_remote_state.database.outputs.address
  db_port     = data.terraform_remote_state.database.outputs.port
  name_bucket = data.terraform_remote_state.bucket.outputs.name_bucket
  owner       = "Nikita Grigorev"
  vpc_id      = data.terraform_remote_state.network.outputs.dev_vpc_id
  subnet_id   = data.terraform_remote_state.network.outputs.dev_public_subnet_ids[0]
  allow_ports = ["80", "443", "22"]
}

#===============================================
