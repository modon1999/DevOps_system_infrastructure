#==============================================================

#========== Local variables ===========

locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

#=============== Security Group for Instance ===============

resource "aws_security_group" "my_webserver" {
  name_prefix = "${var.env}-sg-"
  description = "Security Group for ${var.env}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = local.tcp_protocol
      cidr_blocks = local.all_ips
    }
  }

  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = local.all_ips
  }
  tags = merge(var.common_tags, { env = var.env })
}
