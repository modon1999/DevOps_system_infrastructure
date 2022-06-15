resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "${var.name_bucket}-"
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = var.acl_policy
}
