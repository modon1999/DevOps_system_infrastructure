variable "name" {
  description = "Name of IAM Group and policy this group"
  type        = string
  default     = "example"
}

variable "policy_json" {
  description = "Policy IAM Group in json-format"
  type        = string
}
