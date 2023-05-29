# AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0" 
    }
  }
}

# Configure the AWS Provider region 
provider "aws" {
  region      = "us-east-1"
  profile     = "default"
}

module "vpc" {
  source                    = "./modules/vpc"
#   region                    = 
#   vpc-cidr                  = 
#   public-subnet-1-cidr      = 
#   public-subnet-2-cidr      = 
#   private-subnet-1-cidr     =
#   private-subnet-2-cidr     =  
#   private-subnet-3-cidr     =
#   private-subnet-4-cidr     =  
}

# module "VPC" {
# source            = "./modules/VPC"
# vpc-cidr          ="10.0.0.0/16"
# public-subnet     = "10.0.1.0/24"
# private-subnet    = "10.0.2.0/23"
# }

# module "ec2" {
#   source         = "./modules/ec2"
#   name           = "sam-demo"
#   ami_id         = "ami-0557a15b87f6559cf"
#   instance_type  = "t2.micro"
#   vpc_id         = module.vpc.vpc_id
#   tags           = {}
#   subnet_id      = module.vpc.public_subnet_id[0]
 
  # vpc_id         = "vpc-06c8545f702a3d5f7"
  # subnet_id      = "subnet-0c1bd82bab903fd34"
# }

module "rds" {
  source              = "./modules/rds"
  vpc_id              = module.vpc.vpc_id
  # security_group      = module.ec2.security_groups_id
  given_subnet_id     = module.vpc.public_subnet_id
  # given_subnet_id     = module.vpc.private_subnet_id

  instance_class      = "db.t2.micro"
  dbstorage           = "20"
  engine              = "mysql"
  # engine-version      = "8.0.28"
}

# module "alb"{
#   source                = "./modules/alb"
#   vpc_id                = module.vpc.vpc_id
#   security_groups_id    = module.ec2.security_groups_id
#   public-subnet1        = module.vpc.public_subnet_id[0]
#   public-subnet2        = module.vpc.public_subnet_id[1]
#   ec2_id                = module.ec2.ec2_id    
# }

# module "asg" {
#   source             = "./modules/asg"
#   vpc_id             = module.vpc.vpc_id
#   public_subnet1     = module.vpc.public_subnet1
#   public_subnet2     = module.vpc.public_subnet2
#   security_group_id  = module.ec2.security_groups
# }

# module "s3" {
#   source = "./modules/s3"
# }



