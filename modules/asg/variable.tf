variable "max_size" {
    type = number
    default = 5
    description = "Database size"
}


variable "min_size" {
    type = number
    default = 2
    description = "Database size"
}

variable "ami_id"{
    type = string
    default = "ami-0557a15b87f6559cf"
    description = "AMI ID to deploy EC2 instance"
}

variable "instance_type"{
    type = string
    default = "t2.micro"
    description = "type of instance to deploy"
}

variable "public_subnet1" {}

variable "public_subnet2" {}

variable "vpc_id"{}

variable "security_group_id" {}
