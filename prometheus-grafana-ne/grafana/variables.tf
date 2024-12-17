variable "ami" {
  type    = string
  default = "ami-03eb6185d756497f8"
}

variable "instance_type" {
  type    = string
  default = "c7a.medium"
}


variable "region" {
  description = "Please Enter AWS Region to deploy Server"
  type        = string
  default     = "us-east-1"
}

variable "allow_ports" {
  description = "List of Ports to open for server"
  type        = list
  default     = ["80", "443", "22", "8080", "9090", "50000"]
}

variable "enable_detailed_monitoring" {
  type    = bool
  default = false
}


variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map
  default = {
    Owner       = "Sergei Ches"
    Project     = "Monitoring"
    CostCenter  = "12345"
    Environment = "monitoring"
  }
}
