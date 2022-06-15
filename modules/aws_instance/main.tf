resource "aws_iam_role_policy" "ec2_policy" {
  name_prefix = "${var.env}-${var.name}-"
  role        = aws_iam_role.ec2_role.id
  policy      = var.iam_instance_profile
}

resource "aws_iam_role" "ec2_role" {
  name_prefix        = "${var.env}-${var.name}-"
  assume_role_policy = file("${path.module}/assume_role_policy.json")
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name_prefix = "${var.env}-${var.name}-"
  role        = aws_iam_role.ec2_role.name
}

resource "aws_instance" "my_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data              = var.user_data
  key_name               = var.key_name
  tags                   = merge(var.common_tags, { env = var.env }, { Name = "${var.env}-${var.name}" })
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    volume_size = var.volume_size
  }
}
