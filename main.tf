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





module "ec2_module" {
  source = "/Users/harikishanpv/terraform-aws/modules/ec2"

  #main_sec_grp = aws_security_group.ecs_instance.id
  
}

module "postgress_module" {
  source = "/Users/harikishanpv/terraform-aws/modules/postgress"

  #main_sec_grp = aws_security_group.ecs_instance.id
  
}

