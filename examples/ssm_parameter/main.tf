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

#======= Generate SSM Parameter ===============================

module "ssm_parameter_example" {
  source = "../../modules/ssm_parameter"
}
