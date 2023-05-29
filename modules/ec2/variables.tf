variable "ami_id"{
    type        = string
    default     = "ami-0557a15b87f6559cf"
    description = "AMI ID to deploy EC2 instance"
}

variable "instance_type"{
    type         = string 
    default      = "t2.micro"
    description  = "type of instance to deploy"
}
 
variable "vpc_id"{ 
    # type        = string
    # default     = "vpc-01bebc12182970103"
    # default     = "vpc-06c8545f702a3d5f7" 
    description = "vpc where we will create ec2 instance on it"
} 
 
variable "name"{
    type        =  string
    default     = "sam-demo"
    description = "name of instance"
}
 
variable "tags"{
    default     = {}
    type        = map(string)
    description = "A map of tags to map all resources"
}
variable "subnet_id" {
    # default     = "subnet-0c1bd82bab903fd34"
    # type        = string
    # description = "subnet ID"   
}

