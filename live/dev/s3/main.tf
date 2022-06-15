#============== Provider ==============

provider "aws" {
  region = "eu-central-1"
}

# =================== State ================

terraform {
  backend "s3" {
    # Поменяйте это на имя своего бакета!
    bucket = "modon-example-devops-project-state"
    key    = "dev/s3/terraform.tfstate"
    region = "eu-central-1"
    # Замените это именем своей таблицы DynamoDB!
    # dynamodb_table = "terraform-up-and-running-locks"
    # encrypt        = true
  }
}

#============== S3 Bucket ==============

module "dev_s3_bucket" {
  source      = "../../../modules/s3"
  name_bucket = "dev-bucket"
  acl_policy  = "private"
}
