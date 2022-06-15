# =================== Provider ================

provider "aws" {
  region = "eu-central-1"
}

# =================== State ================

terraform {
  backend "s3" {
    # Поменяйте это на имя своего бакета!
    bucket = "modon-example-devops-project-state"
    key    = "global/iam/iam_group/devops/terraform.tfstate"
    region = "eu-central-1"
    # Замените это именем своей таблицы DynamoDB!
    # dynamodb_table = "terraform-up-and-running-locks"
    # encrypt        = true
  }
}

# =================== Create group ================

module "devops_group" {
  source      = "../../../../../modules/iam_group/"
  name        = "devops-group"
  policy_json = file("policy_devops.json")
}
