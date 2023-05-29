output "rds_id"{
    value = aws_db_instance.rds.id
}

output "security_groups_id" {
    value = aws_security_group.database_security_group.id
}

