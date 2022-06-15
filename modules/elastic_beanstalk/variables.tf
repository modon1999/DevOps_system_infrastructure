variable "env" {
  type    = string
  default = "dev"
}

variable "arn_platform" {
  description = "Arn platform for Elastic Beanstalk"
  type        = string
}

variable "common_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the EB"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the EB"
  type        = number
  default     = 1
}

variable "type_lb" {
  description = "The type of Load Balancer"
  type        = string
  default     = "classic"
}

variable "vpc_id" {
  description = "ID VPC for EB"
  type        = string
}

variable "application_subnets" {
  type        = list(string)
  description = "List of subnets to place EC2 instances"
}

variable "elb_scheme" {
  description = "Specify internal if you want to create an internal load balancer"
  type        = string
  default     = "public"
}

variable "update_type" {
  description = "Type update new application"
  type        = string
  default     = "Time"
}

variable "deployment_type" {
  description = "Type new deployment"
  type        = string
  default     = "AllAtOnce"
}

variable "scalling_type" {
  description = "Type scalling instance"
  type        = string
  default     = "CPUUtilization"
}

variable "statistic" {
  description = "The Statistic the trigger uses"
  type        = string
  default     = "Average"
}

variable "unit" {
  description = "Unit of scalling"
  type        = string
  default     = "Percent"
}

variable "lower_threshold" {
  description = "Lower threshold for scalling"
  type        = number
  default     = 20
}

variable "upper_threshold" {
  description = "Upper threshold for scalling"
  type        = number
  default     = 80
}

variable "period_scalling" {
  description = "Load check period"
  type        = number
  default     = 5
}

variable "breach_duration" {
  description = "Load duration for scalling, mins"
  type        = number
  default     = 15
}

variable "environment_variables_map" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {}
}

variable "key_for_instance" {
  description = "Key for instance in EB"
  type        = string
  default     = ""
}
