# variable "ami_id"{
#     type = string
#     default = "ami-0557a15b87f6559cf"
#     description = "AMI ID to deploy EC2 instance"
# }

# variable "instance_type"{
#     type = string
#     default = "t2.micro"
#     description = "type of instance to deploy"
# }

variable "vpc-cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "VPC CIDR Block"
}

variable "public-subnet1" {
  type = string
  default = "10.0.1.0/24"
  description = "Public Subnet CIDR Block"
}

variable "public-subnet2" {
  type = string
  default = "10.0.2.0/24"
  description = "Public Subnet CIDR Block"
}

variable "private-subnet1" {
  type = string
  default = "10.0.3.0/24"
  description = "Private Subnet CIDR Block"
}

variable "private-subnet2" {
  type = string
  default = "10.0.4.0/24"
  description = "Private Subnet CIDR Block"
}
 




