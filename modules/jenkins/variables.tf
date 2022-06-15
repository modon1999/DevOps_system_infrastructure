variable "subnet_id" {
  description = "Subnet for instance"
  type        = string
}

variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map(any)
  default = {
    Project = "Terraform Lessons"
  }
}

variable "vpc_id" {
  description = "VPC for Security Group"
  type        = string
}

variable "env" {
  description = "Enviroment instance"
  type        = string
  default     = "jenkins"
}

variable "allow_ports" {
  description = "List of Ports to open for Server"
  type        = list(any)
  default     = ["80", "443", "22", "8080"]
}

variable "name_bucket" {
  description = "Name bucket fot attach instance"
  type        = string
}
