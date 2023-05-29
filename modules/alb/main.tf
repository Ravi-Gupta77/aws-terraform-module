resource "aws_lb" "application-lb"{
  name               = "test-alb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  enable_deletion_protection = false
  security_groups    = [var.security_groups_id]
  # subnets            = [for id in module.VPC.public_subnet_id: public_subnet_id]
  subnets            = [var.public-subnet1, var.public-subnet2]
  
  tags = {
    Environment = "test-alb"
  }
}
   
# Creating security group 
# resource "aws_security_group" "web-server" {
#   name        = "web-server"
#   description = "Allow incoming HTTP connection"
    
#    ingress {
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#    }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "allow_tls"
#   }
# }


#creating listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}

# Create Target group
resource "aws_lb_target_group" "target-group" {
    protocol = "HTTP"
    name     = "test-alb"
    port     = 80
    target_type = "instance" 
    vpc_id   = "${var.vpc_id}"
    
    health_check {
    path = "/"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
    protocol = "HTTP"
    matcher = "200"
    }
}

#Attach target group to ALB
resource "aws_lb_target_group_attachment" "aws-target-group" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id = var.ec2_id
  port = 80 
}








