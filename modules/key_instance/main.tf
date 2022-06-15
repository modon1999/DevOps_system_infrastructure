#================== Key create ================

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name_prefix = var.name_key
  public_key      = tls_private_key.example.public_key_openssh
}
