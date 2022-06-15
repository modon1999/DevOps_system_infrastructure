#================== Provider ================

provider "aws" {
  region = "eu-central-1"
}

#================== Modules ================

module "key_default" {
  source = "../../modules/key_instance"
}
