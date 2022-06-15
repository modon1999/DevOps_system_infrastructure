output "dns_eb" {
  value = aws_elastic_beanstalk_environment.eb_env.cname
}
