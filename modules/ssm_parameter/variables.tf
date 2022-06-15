variable "description" {
  description = "Description SSM Parameter"
  type        = string
  default     = "There should be a description here"
}

variable "password_name_db" {
  description = "The name for the database"
  type        = string
  default     = "/example"
}

variable "type_ssm" {
  description = "Type of SSM Parameter"
  type        = string
  default     = "SecureString"
}

variable "value" {
  description = "Value secure string"
  type        = string
  default     = "111111111111"
}
