variable "dbstorage" {
    type = number
    default = "20"
    description = "Database size"
}

variable "instance_class" {
    type = string
    default = "db.t2.micro"
    description = "Type of instance class"
}

variable "engine-version" {
    type = string
    default = "5.7"
    description = "Engine version for the RDS engine"
}

variable "engine" {
    type = string
    default = "mysql"
    description = "Engine type for the RDS"
}


variable "vpc_id"{

}

# variable "security_group" {
#     type = string
#     default = " "
#     description = "Same security group of the ec2"  
# }

variable "given_subnet_id" {
    description = "Public subnet ids for the rds instance"
    # type = list(string)
    # default = [ "value" ]
}