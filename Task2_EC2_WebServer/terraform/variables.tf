
variable "ami" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0cd2eceadbc14f47a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "sid_phrase_key"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "email" {
  description = "Email for SNS alerts"
  type        = string
  default     = "siddharthkolapaka@gmail.com"
}

