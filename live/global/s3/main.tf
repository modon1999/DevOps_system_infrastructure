# =================== Provider ================

provider "aws" {
  region = "eu-central-1"
}

# =================== Bucket ================
resource "aws_s3_bucket" "terraform_state" {
  bucket = "modon-example-devops-project-state"
  # Предотвращаем случайное удаление этого бакета S3
  # lifecycle {
  #   prevent_destroy = true
  # }
}

# =================== Versioning ================

# resource "aws_s3_bucket_versioning" "versioning_example" {
#   # Включаем управление версиями, чтобы вы могли просматривать
#   # всю историю ваших файлов состояния
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }
#
# =================== Encryption ================

# resource "aws_kms_key" "key_for_bucket" {
#   description             = "This key is used to encrypt bucket objects"
#   deletion_window_in_days = 10
# }
#
# resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
#   # Включаем шифрование по умолчанию на стороне сервера
#   bucket = aws_s3_bucket.terraform_state.bucket
#
#   rule {
#     apply_server_side_encryption_by_default {
#       kms_master_key_id = aws_kms_key.key_for_bucket.arn
#       sse_algorithm     = "aws:kms"
#     }
#   }
# }
#
# =================== Lock State ================

# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "terraform-up-and-running-locks"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"
#
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# ==================== State =================

# terraform {
#   backend "s3" {
#     # Поменяйте это на имя своего бакета!
#     bucket = "modon-terraform-up-and-running-state"
#     key    = "global/s3/terraform.tfstate"
#     region = "eu-central-1"
#     # Замените это именем своей таблицы DynamoDB!
#     dynamodb_table = "terraform-up-and-running-locks"
#     encrypt        = true
#   }
# }
