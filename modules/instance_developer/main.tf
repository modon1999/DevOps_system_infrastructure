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
    owner       = var.owner
    name_bucket = var.name_bucket
    db_address  = var.db_address
    db_port     = var.db_port
  }
}

data "template_file" "policy_developer" {
  template = file("${path.module}/policy_developer.json.tpl")
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
  common_tags = merge(var.common_tags, { Owner = var.owner })
}

module "key_instance" {
  source   = "../key_instance/"
  name_key = var.env
}


module "server" {
  source                 = "../aws_instance"
  ami                    = data.aws_ami.latest_amazon_linux.id
  env                    = var.env
  subnet_id              = var.subnet_id
  instance_type          = "t2.micro"
  name                   = var.name
  key_name               = module.key_instance.name_key
  vpc_security_group_ids = [module.security_group.security_group_id]
  user_data              = data.template_file.user_data.rendered
  iam_instance_profile   = data.template_file.policy_developer.rendered
  common_tags            = merge(var.common_tags, { Owner = var.owner })
}

#===============================================
