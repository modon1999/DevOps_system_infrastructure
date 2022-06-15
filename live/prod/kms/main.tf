#========== Version ===========
#
# terraform {
#
#   # Требуем исключительно версию Terraform 1.1.6
#
#   required_version = "= 1.1.6"
#
# }

#======= Provider ===============================

provider "aws" {
  region = "eu-central-1"
}

# =================== State ================

terraform {
  backend "s3" {
    # Поменяйте это на имя своего бакета!
    bucket = "modon-example-devops-project-state"
    key    = "prod/kms/terraform.tfstate"
    region = "eu-central-1"
    # Замените это именем своей таблицы DynamoDB!
    # dynamodb_table = "terraform-up-and-running-locks"
    # encrypt        = true
  }
}

#======= Generate Password for Stage DB ===============================

resource "random_string" "rds_password" {
  length           = 12
  special          = true
  override_special = "!#$%"
  keepers = { # if it's parameter was change, resourse was be recreate
    keeper1 = 1
  }
}

module "ssm_parameter_db_prod" {
  source           = "../../../modules/ssm_parameter"
  password_name_db = "/prod/db"
  description      = "Password for database Prod"
  type_ssm         = "SecureString"
  value            = random_string.rds_password.result
}
