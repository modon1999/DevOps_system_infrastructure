variable "name_db" {
  description = "The name for the database"
  type        = string
  default     = "example"
}

variable "type_db" {
  description = "The name for the database"
  type        = string
  default     = "db.t2.micro"
}

variable "storage" {
  description = "The name for the database"
  type        = string
  default     = "10"
}

variable "subnets_db" {
  description = "Subnets for Database Instance"
  type        = list(string)
}

variable "env" {
  type    = string
  default = "dev"
}

variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map(any)
  default = {
    Owner   = "Nikita Grigorev"
    Project = "Terraform Lessons"
  }
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  default     = "1"
}
