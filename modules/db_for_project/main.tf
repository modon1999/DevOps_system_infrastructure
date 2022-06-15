#========== Version ===========
#
# terraform {
#
#   # Требуем исключительно версию Terraform 1.1.6
#
#   required_version = "= 1.1.6"
#
# }

#======= Generate Password for DB ===============================

resource "random_string" "rds_password" {
  length           = 12
  special          = true
  override_special = "!@#$%"
  keepers = { # if it's parameter was change, resourse was be recreate
    keeper1 = var.db_password
  }
}

module "ssm_parameter" {
  source           = "../ssm_parameter"
  password_name_db = "/${var.env}db"
  description      = "Password for enviroment ${var.env}-DB"
  type_ssm         = "SecureString"
  value            = random_string.rds_password.result
}

#===================== Data Base =====================================

module "mysql" {
  env         = var.env
  source      = "../mysql"
  password_db = module.ssm_parameter.secure_string
  name_db     = var.name_db
  type_db     = var.type_db
  storage     = var.storage
  username_db = "admin"
  subnets_db  = var.subnets_db
  common_tags = var.common_tags
}
