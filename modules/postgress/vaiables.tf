variable "rds_identifier" {
  default = "db-ec2-test"
}

variable "rds_instance_type" {
  default = "db.t3.micro"
}
variable "rds_storage_size" {
  default = "5"
}

variable "rds_engine" {
  default = "postgres"
}

variable "rds_engine_version" {
  default = "13.7"
}

variable "rds_db_name" {
  default = "demo_db"
}

variable "rds_admin_user" {
  default = "dbadmin"
}

variable "rds_admin_password" {
  default = "haripwd123"
}

variable "rds_publicly_accessible" {
  default = "true"
}

variable "ecs_cluster_name" {
  type    = string
  default = "ecs-cluster"
}

variable "environment_name" {
  type    = string
  default = "dev"
}