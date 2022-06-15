#================== Provider ================

provider "aws" {
  region = "eu-central-1"
}

#=============== State ===============

terraform {
  backend "s3" {
    # Поменяйте это на имя своего бакета!
    bucket = "modon-example-devops-project-state"
    key    = "global/iam/iam_users/developers/terraform.tfstate"
    region = "eu-central-1"
    # Замените это именем своей таблицы DynamoDB!
    # dynamodb_table = "terraform-up-and-running-locks"
    # encrypt        = true
  }
}

#================== Data ================

data "terraform_remote_state" "iam_group" {
  backend = "s3"
  config = {
    bucket = "modon-example-devops-project-state"                // Bucket from where to GET Terraform State
    key    = "global/iam/iam_group/developers/terraform.tfstate" // Object name in the bucket to GET Terraform state
    region = "eu-central-1"                                      // Region where bycket created
  }
}

#======= Create IAM group ===============================

module "developer1" {
  source            = "../../../../../modules/iam_user/"
  name_user         = "developer1"
  attach_group      = [data.terraform_remote_state.iam_group.outputs.name_group]
  enable_access_key = true
  enable_password   = false
}

module "developer2" {
  source            = "../../../../../modules/iam_user/"
  name_user         = "developer2"
  attach_group      = [data.terraform_remote_state.iam_group.outputs.name_group]
  enable_access_key = true
  enable_password   = false
}
