#=========== Data ======================

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh.tpl")
  vars = {
    env         = var.env
    name_bucket = var.name_bucket
  }
}

data "template_file" "policy_jenkins" {
  template = file("${path.module}/policy_jenkins.json.tpl")
  vars = {
    name_bucket = var.name_bucket
  }
}

#=========== Modules ======================

module "security_group" {
  source      = "../aws_security_group"
  vpc_id      = var.vpc_id
  env         = var.env
  allow_ports = var.allow_ports
  common_tags = var.common_tags
}

module "key_instance" {
  source   = "../key_instance/"
  name_key = var.env
}

module "server" {
  source                 = "../aws_instance"
  ami                    = data.aws_ami.latest_amazon_linux.id
  name                   = "jenkins"
  env                    = var.env
  subnet_id              = var.subnet_id
  instance_type          = "t2.micro"
  volume_size            = "30"
  key_name               = module.key_instance.name_key
  vpc_security_group_ids = [module.security_group.security_group_id]
  user_data              = data.template_file.user_data.rendered
  iam_instance_profile   = data.template_file.policy_jenkins.rendered
  common_tags            = var.common_tags
}

#===============================================
