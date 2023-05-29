output "ec2_id"{
    value = aws_instance.ec2.id
}

output "security_groups_id" {
    value = aws_security_group.ec2-sg.id
}


# output "ec2-sg-egress"{
#     value = aws_security_group_rule.ec2-sg-egress.id
# } 
  