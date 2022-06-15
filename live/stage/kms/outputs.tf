output "password_db_stage" {
  value       = module.ssm_parameter_db_stage.secure_string
  description = "Value secure string"
  sensitive   = true
}
