#========== Version ===========
#
# terraform {
#
#   # Требуем исключительно версию Terraform 1.1.6
#
#   required_version = "= 1.1.6"
#
# }

#======= Generate SSM Parameter ===============================

resource "aws_ssm_parameter" "rds_password" {
  name        = var.password_name_db
  description = var.description
  type        = var.type_ssm
  value       = var.value
}

data "aws_ssm_parameter" "db_password" {
  name       = var.password_name_db
  depends_on = [aws_ssm_parameter.rds_password]
}
