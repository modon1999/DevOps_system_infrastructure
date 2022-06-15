output "password_db_prod" {
  value       = module.ssm_parameter_db_prod.secure_string
  description = "Value secure string"
  sensitive   = true
}
