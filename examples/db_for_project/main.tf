#================== Provider ================
provider "aws" {
  region = "eu-central-1"
}

#================== Modules ================

module "db_project_example" {
  source      = "../../modules/db_for_project/"
  db_password = 1
  env         = var.env
  name_db     = "db"
  type_db     = "db.t2.micro"
  storage     = 10
  subnets_db  = ["subnet-0123cc68b6f226f49", "subnet-0584e5c71877dcd0d"]
}
