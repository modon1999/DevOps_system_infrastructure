#======= Create IAM group ===============================

resource "aws_iam_user" "example" {
  name = var.name_user

  tags = {
    Project = "Terraform"
  }
}

resource "aws_iam_access_key" "example" {
  count = var.enable_access_key ? 1 : 0
  user  = aws_iam_user.example.name
}

resource "aws_iam_user_group_membership" "example1" {
  user   = aws_iam_user.example.name
  groups = var.attach_group
}

resource "aws_iam_user_login_profile" "example" {
  count = var.enable_password ? 1 : 0
  user  = aws_iam_user.example.name
}
