resource "aws_security_group" "ec2-sg"{
    name        = "${var.name}-sg"
    description = "EC2 security group"
    vpc_id      =  var.vpc_id
    
    # lifecycle {
    # create_before_destroy = true
    # }

    ingress {
        description     = "HTTP"
        from_port       = 80
        to_port         = 80
        protocol        = "TCP"
        cidr_blocks     = ["0.0.0.0/0"] 
    } 

    # ingress {
    #     description     = "HTTPS"
    #     from_port       = 443
    #     to_port         = 443
    #     protocol        = "TCP"
    #     cidr_blocks     = ["0.0.0.0/0"] 
    # }

    ingress {
        description     = "SSH"
        from_port       = 22
        to_port         = 22
        protocol        = "TCP"
        cidr_blocks     = ["0.0.0.0/0"] 
    }

      ingress {
        description     = "custom TCP"
        from_port       = 8000
        to_port         = 8000
        protocol        = "TCP"
        cidr_blocks     = ["0.0.0.0/0"] 
    }

    egress {
        from_port         = 0
        to_port           = 0
        protocol          = "-1"
        cidr_blocks       = ["0.0.0.0/0"]
    }

    tags = {
        Name = "ravi-ec2-sg"
    }  
}


# resource "aws_security_group_rule" "ec2-sg-http"{
#     type = "ingress"
#     security_group_id = aws_security_group.ec2-sg.id
#     from_port = 80
#     to_port = 80
#     protocol = "TCP"
#     cidr_blocks = ["0.0.0.0/0"] 
# }

# resource "aws_security_group_rule" "ec2-sg-https"{
#     type = "ingress"
#     security_group_id = aws_security_group.ec2-sg.id
#     from_port = 443
#     to_port = 443
#     protocol = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "ec2-sg-ssh"{
#     type = "ingress"
#     security_group_id = aws_security_group.ec2-sg.id
#     from_port = 22
#     to_port = 22
#     protocol = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "ec2-sg-egress"{
#     type              = "egress"
#     security_group_id = aws_security_group.ec2-sg.id
#     from_port         = 0
#     to_port           = 0
#     protocol          = "-1"
#     cidr_blocks       = ["0.0.0.0/0"]
# }
  
resource "aws_instance" "ec2"{
    # name                    = var.name
    ami                     = var.ami_id
    instance_type           = var.instance_type
    subnet_id               = var.subnet_id
    key_name                = "ansible-key"
    security_groups         = [aws_security_group.ec2-sg.id]
   
    root_block_device{
    volume_size      = 8
    volume_type      = "gp3"
    encrypted        = true
    }
      
    tags             = merge(
    var.tags,
    {
    Name             = var.name 
    }
    )
}
