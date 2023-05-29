output "vpc_id"{
    value = aws_vpc.ravi.id
}

# output "public_subnet1" {
#     value = aws_subnet.ravi-public-subnet1.id
# }

# output "public_subnet2" {
#     value = aws_subnet.ravi-public-subnet2.id
# }

output "public_subnet_id" {
    value = [aws_subnet.ravi-public-subnet1.id, aws_subnet.ravi-public-subnet2.id]
}


# output "private_subnet1" {
#     value = aws_subnet.ravi-private-subnet1.id
# }

# output "private_subnet2" {
#     value = aws_subnet.ravi-private-subnet2.id
# }

output "private_subnet_id" {
    value = [aws_subnet.ravi-private-subnet1.id, aws_subnet.ravi-private-subnet2.id]
}