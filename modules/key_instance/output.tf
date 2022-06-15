output "name_key" {
  value       = aws_key_pair.generated_key.key_name
  description = "Name of SSH key"
}
