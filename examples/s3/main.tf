#============== Provider ==============

provider "aws" {
  region = "eu-central-1"
}

#============== S3 Bucket ==============

module "s3_bucket" {
  source      = "github.com/modon1999/Project_happy_birthday//modules/s3?ref=v0.0.4"
  name_bucket = "example"
  acl_policy  = "private"
  website     = true
}
