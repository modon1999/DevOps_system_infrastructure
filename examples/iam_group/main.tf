#======= Provider ===============================

provider "aws" {
  region = "eu-central-1"
}

#======= Create IAM user ===============================

module "example_group" {
  source      = "../../modules/iam_group"
  name        = "example"
  policy_json = file("policy_example.json")
}
