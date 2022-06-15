variable "name_user" {
  description = "Name of IAM User"
  type        = string
  default     = "example"
}

variable "attach_group" {
  description = "Name attach IAM Group to user"
  type        = list(any)
}

variable "enable_access_key" {
  description = "Enable access key for user"
  type        = bool
  default     = false
}

variable "enable_password" {
  description = "Enable password for user"
  type        = bool
  default     = false
}
