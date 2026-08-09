variable "aws_region" {

  description = "AWS region"

  type = string

  default = "ap-south-1"

}


variable "project_name" {

  description = "Project name"

  type = string

  default = "shopsphere"

}


variable "environment" {

  description = "Environment"

  type = string

  default = "dev"

}


variable "vpc_cidr" {

  description = "VPC CIDR"

  type = string

  default = "10.0.0.0/16"

}


variable "db_username" {

  description = "RDS username"

  type = string

  default = "shopsphere"

}


variable "db_password" {

  description = "RDS password"

  type = string

  sensitive = true
}
