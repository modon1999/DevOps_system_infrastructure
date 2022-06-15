# =================== Provider ================

provider "aws" {
  region = "eu-central-1"
}

# =================== State ================

terraform {
  backend "s3" {
    # Поменяйте это на имя своего бакета!
    bucket = "modon-example-devops-project-state"
    key    = "global/iam/iam_group/developers/terraform.tfstate"
    region = "eu-central-1"
    # Замените это именем своей таблицы DynamoDB!
    # dynamodb_table = "terraform-up-and-running-locks"
    # encrypt        = true
  }
}

# =================== Create group ================

module "developers_group" {
  source      = "../../../../../modules/iam_group/"
  name        = "developers-group"
  policy_json = file("policy_developer.json")
}
