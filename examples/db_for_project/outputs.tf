output "address" {
  value       = module.db_project_example.address
  description = "Connect to the database at this endpoint"
}

output "port" {
  value       = module.db_project_example.port
  description = "The port the database is listening on"
}
