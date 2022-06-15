output "secure_string" {
  value       = module.ssm_parameter_example.secure_string
  description = "Value secure string"
  sensitive   = true
}
