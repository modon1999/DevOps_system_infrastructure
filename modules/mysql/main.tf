#========== Version ===========
#
# terraform {
#
#   # Требуем исключительно версию Terraform 1.1.6
#
#   required_version = "= 1.1.6"
#
# }

#===================== Data Base =====================================

resource "aws_db_subnet_group" "db_instance" {
  name_prefix = "${var.env}-${var.name_db}-"
  subnet_ids  = var.subnets_db
  description = "Subnets for Database ${var.env}-${var.name_db}-DB"
  tags        = merge(var.common_tags, { env = var.env })
}

resource "aws_db_instance" "example" {
  identifier_prefix    = "${var.env}-${var.name_db}-"
  engine               = "mysql"
  allocated_storage    = var.storage
  instance_class       = var.type_db
  db_name              = "${var.env}_database"
  username             = var.username_db
  password             = var.password_db
  db_subnet_group_name = aws_db_subnet_group.db_instance.name
  skip_final_snapshot  = true
  tags                 = merge(var.common_tags, { env = var.env })
}
