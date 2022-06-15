#================== Provider ================

provider "aws" {
  region = "eu-central-1"
}

#================== Create eb app ================

module "elastic_beanstalk" {
  source              = "../../modules/elastic_beanstalk"
  env                 = var.env
  arn_platform        = "arn:aws:elasticbeanstalk:eu-central-1::platform/PHP 8.0 running on 64bit Amazon Linux 2/3.3.11"
  vpc_id              = "vpc-06e8f251b98b74274"
  application_subnets = ["subnet-07f43463a3537b2aa", "subnet-036a585fa18180ecf"]
}
