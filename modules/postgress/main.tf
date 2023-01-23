resource "aws_db_instance" "dev_db" {
  engine            = "${var.rds_engine}"
  engine_version    = "${var.rds_engine_version}"
  identifier        = "${var.rds_identifier}"
  instance_class    = "${var.rds_instance_type}"
  allocated_storage = "${var.rds_storage_size}"
  db_name              = "${var.rds_db_name}"
  username          = "${var.rds_admin_user}"
  password          = "${var.rds_admin_password}"
  publicly_accessible    = "${var.rds_publicly_accessible}"
  vpc_security_group_ids = ["${aws_security_group.dev_rds_security_group.id}"]
  backup_retention_period = 0
  final_snapshot_identifier = "dev-db2-sp"
  skip_final_snapshot = true
  apply_immediately = true
  # availability_zone = "us-east-1a" 
  tags = {
    Name = "test-Database "
  }
}

# module "ec2_module_c" {
#   source = "/Users/harikishanpv/terraform-aws/modules/ec2"

#   #main_sec_grp = aws_security_group.ecs_instance.id
  
# }