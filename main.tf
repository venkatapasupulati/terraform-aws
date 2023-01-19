terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50.0"
    }
  }

#   required_version = ">= 1.2.0"
}

provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    profile                 = "adfs"
    region  = "us-east-1"
}

resource "aws_instance" "ec2_h" {
  ami           = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2-key.key_name
  vpc_security_group_ids = [aws_security_group.ecs_instance.id]
  #subnet_id = "${var.subnet_id}"
  tags = {
    Name = "${var.environment_name}-${var.ecs_cluster_name}"
  }

connection {
    # The default username for our AMI
    user = "ec2-user"
    type = "ssh"
    private_key = file("hari-key.pem")
    host        = self.public_ip
    # The connection will use the local SSH agent for authentication.
  }
    # install java, create dir
  provisioner "remote-exec" {
    inline = [
      
      "sudo amazon-linux-extras install java-openjdk11",      
      "mkdir data",
      "cd data",
      "mkdir service",
      "cd ..",
    ]
  }
}

resource "aws_security_group" "ecs_instance" {
  name        = "${var.environment_name}-${var.ecs_cluster_name}-ec2-sg"
  description = "${var.environment_name}-${var.ecs_cluster_name}-ec2-sg"
  #vpc_id      = "${var.vpc_id}"
#   vpc_id      = data.aws_vpc.main.id 

  tags = {
    Name      = "${var.environment_name}-${var.ecs_cluster_name}-ec2-sg"
  }
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.ecs_instance.id
  description       = "TCP/22 for VPC Range"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["108.247.90.198/32"]
  #159.53.0.0/16
}

resource "aws_security_group_rule" "ec2_egress" {
  security_group_id = aws_security_group.ecs_instance.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# resource "aws_key_pair" "ec2-key" {
#     key_name = "ec2-key"
#     public_key = file("~/Desktop/MSDocs/pcl/ec2-key.pub")
  
# }

resource "tls_private_key" "this" {
  algorithm     = "RSA"
  rsa_bits      = 4096
}

resource "aws_key_pair" "ec2-key" {
  key_name      = "hari-key"
  public_key    = tls_private_key.this.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOT
      echo "${tls_private_key.this.private_key_pem}" > hari-key.pem
    EOT
  }
}