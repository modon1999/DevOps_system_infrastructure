#======= Create IAM group ===============================

resource "aws_iam_group" "example" {
  name = var.name
}

resource "aws_iam_group_policy" "example" {
  name  = var.name
  group = aws_iam_group.example.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = var.policy_json
}
