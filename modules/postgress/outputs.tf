output "RDS" {
  value = "address: ${aws_db_instance.dev_db.address}"
}

output "pg_sg_grp"{

  value="${aws_security_group.dev_rds_security_group.id}"
}