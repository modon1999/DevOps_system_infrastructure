#================== Provider ================
provider "aws" {
  region = "eu-central-1"
}

#======= Generate Password for DB ===============================
resource "random_string" "rds_password" {
  length           = 12
  special          = true
  override_special = "!@#$%"
}

module "ssm_parameter" {
  source           = "../../modules/ssm_parameter"
  password_name_db = "/${var.env}db"
  description      = "Password for enviroment ${var.env}-DB"
  type_ssm         = "SecureString"
  value            = random_string.rds_password.result
}

#================== Modules ================

module "mysql" {
  env         = var.env
  source      = "../../modules/mysql"
  password_db = module.ssm_parameter.secure_string
  name_db     = "db"
  type_db     = "db.t2.micro"
  storage     = 10
  username_db = "admin"
  subnets_db  = ["subnet-0123cc68b6f226f49", "subnet-0584e5c71877dcd0d"]
}
