module "vpc" {

  source = "terraform-aws-modules/vpc/aws"

  version = "6.5.1"


  name = "${var.project_name}-vpc"

  cidr = var.vpc_cidr


  azs = [
    "${var.aws_region}a",
    "${var.aws_region}b"
  ]


  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]


  private_subnets = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]


  enable_nat_gateway = true

  single_nat_gateway = true


  enable_dns_hostnames = true

  enable_dns_support = true


  public_subnet_tags = {

    "kubernetes.io/role/elb" = "1"

  }


  private_subnet_tags = {

    "kubernetes.io/role/internal-elb" = "1"

  }


  tags = {

    Project = var.project_name

    Environment = var.environment

  }

}


variable "project_name" {

  type = string

}


variable "environment" {

  type = string

}


variable "aws_region" {

  type = string

}


variable "vpc_cidr" {

  type = string

}


output "vpc_id" {

  value = module.vpc.vpc_id

}


output "private_subnets" {

  value = module.vpc.private_subnets

}


output "public_subnets" {

  value = module.vpc.public_subnets

}
