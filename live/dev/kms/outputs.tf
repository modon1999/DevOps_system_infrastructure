output "password_db_dev" {
  value       = module.ssm_parameter_db_dev.secure_string
  description = "Value secure string"
  sensitive   = true
}
