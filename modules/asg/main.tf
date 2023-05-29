resource "aws_launch_template" "ec2" {
    image_id = var.ami_id
    instance_type = var.instance_type
    key_name = "ravi-key"
    # security_groups = [var.security_group_id]
    
    network_interfaces {
    associate_public_ip_address = true
    # security_groups = var.security_group_id
    }

}
 
resource "aws_autoscaling_group" "example" {
  name                      = "example-autoscaling-group"
  # availability_zones        = ["us-east-1a"]
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  # vpc_id                    = "${var.vpc_id}"
  vpc_zone_identifier       = [var.public_subnet1, var.public_subnet2] 
  
  mixed_instances_policy {
  launch_template {
    
    launch_template_specification {
    launch_template_id      = aws_launch_template.ec2.id
    }
   
  }
  
  }
 
  tag {
    key                 = "Name"
    value               = "example-instance"
    propagate_at_launch = true
    }
 
  lifecycle {
    create_before_destroy = true
    }
}

# scale up policy
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "asg_scale_up"
  autoscaling_group_name = aws_autoscaling_group.example.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300 
  policy_type            = "SimpleScaling"
}

#scale up alarm. This will trigger asg policy based on various metrics 
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name                = "asg-scale-up-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 40
  # alarm_description         = "This metric monitors ec2 cpu utilization"
  # insufficient_data_actions = []
  actions_enabled            = "true" 
  # alarm_actions             = [aws_autoscaling_group.scale_up.arn]
}


#scale down policy
resource "aws_autoscaling_policy" "scale_down" {
  name = "asg_scale_down"
  autoscaling_group_name = aws_autoscaling_group.example.name
  adjustment_type       = "ChangeInCapacity"
  scaling_adjustment    = -1
  cooldown              = 300 
  policy_type           = "SimpleScaling"
}

#scale down alarm
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name                = "asg-scale-up-alarm"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 20
  # alarm_description         = "This metric monitors ec2 cpu utilization"
  # insufficient_data_actions = []
  actions_enabled = "true" 
  # alarm_actions = [aws_autoscaling_group.scale_down.arn]
}







