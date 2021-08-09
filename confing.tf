variable "instance_type" {
  description = "free tier is t2.micro"
  type        = string
  default     = "t2.micro"
}

variable "ssh_user" {
  description = "ubuntu user default"
  type        = string
  default     = "ubuntu"
}

variable "apache_port" {
  description = "apache port default 8080"
  type        = number
  default     = 8080
}
