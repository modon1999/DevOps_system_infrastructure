output "secure_string" {
  value       = data.aws_ssm_parameter.db_password.value
  description = "Value secure string"
  sensitive   = true
}
