variable "ecs_cluster_name" {
  type    = string
  default = "ecs-cluster"
}

variable "environment_name" {
  type    = string
  default = "dev"
}

variable "subnet_id" {
    type = string
    default = "subnet-02fa3a0926d37eb92"
  
}

variable "vpc_id" {
    type = string
    default = "vpc-026abacf41e619505"
  
}