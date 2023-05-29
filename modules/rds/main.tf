# security group for RDS
# resource "aws_security_group" "rds" {
#   name_prefix = "rds"
#   vpc_id = var.vpc_id
#   ingress{
#     from_port        = 3306
#     to_port          = 3306
#     protocol         = "TCP"
#     cidr_blocks      = ["0.0.0.0/0"]
#     security_groups  = [var.security_group]
#   }
#   # egress{
  #   from_port        = 0
  #   to_port          = 0
  #   protocol         = "-1"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }
# }

# create security group for the web server
resource "aws_security_group" "webserver_security_group" {
  name        = "webserver security group"
  description = "enable http access on port 80"
  vpc_id      = var.vpc_id

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "rds-security-group"
  }
}

# create security group for the database
resource "aws_security_group" "database_security_group" {
  name        = "database security group"
  description = "enable mysql/aurora access"
  vpc_id = var.vpc_id
  ingress {
    description      = "mysql/aurora access"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_security_group.id]
  }

  ingress {
    description     = "SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    cidr_blocks     = ["0.0.0.0/0"] 
  }

  egress{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}



resource "aws_db_subnet_group" "db_subnet_group" {
  name = "rds_subnet_group"
  description = "DB subnet group for tutorial"
  # subnet_ids = [given_subnet_id[0]]
  subnet_ids = [for id in var.given_subnet_id : id]
  # subnet_ids  = var.given_subnet_id
}


# Create RDS database 
resource "aws_db_instance" "rds" {
   allocated_storage       = var.dbstorage
   storage_type            = "gp2"
   identifier              = "employee-management"
   engine                  = var.engine
   engine_version          = var.engine-version
   instance_class          = var.instance_class
   username                = "ravi"
   password                = "ravi#!123"
   publicly_accessible     = true
   skip_final_snapshot     = true
   vpc_security_group_ids  = [aws_security_group.database_security_group.id]
   db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.id
   
   tags = {
     Name = "employee RDS"
   }
 
}





