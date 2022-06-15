#================== Provider ================

provider "aws" {
  region = "eu-central-1"
}

#======= Create IAM group ===============================

module "example" {
  source            = "../../modules/iam_user/"
  name_user         = "example"
  attach_group      = []
  enable_access_key = true
}
