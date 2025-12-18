variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
  description = "This is RHEL9 DevOps Ami id"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "ec2_tags" {
  type        = map
  default     = {
    project = "expense"
    component ="backend"
    environment = "dev"
  }
}

variable "from_port" {
    type = number
    default = 22
}

variable "to_port" {
    type = number
    default = 22
}

variable "cidr_blocks" {
    type = list(string)
    default = ["0.0.0.0/0"]
}

variable "sg_tags"{
    default= {
        Name = "expense-backend-dev"
    }
}


