resource "aws_security_group" "dev_rds_security_group" {
    name        = "${var.environment_name}-${var.ecs_cluster_name}-rds-sg"
    description   = "${var.environment_name}-${var.ecs_cluster_name}-rds-sg"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["108.247.90.198/32","172.31.0.0/16","172.31.48.0/20"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.environment_name}-${var.ecs_cluster_name}-ec2-sg"
  }
}