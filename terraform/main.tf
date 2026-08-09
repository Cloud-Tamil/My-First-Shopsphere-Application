locals {

  name =
    "${var.project_name}-${var.environment}"

}


module "vpc" {

  source = "./modules/vpc"


  project_name =
    local.name

  environment =
    var.environment

  aws_region =
    var.aws_region

  vpc_cidr =
    var.vpc_cidr

}


module "ecr" {

  source = "./modules/ecr"


  project_name =
    local.name

}


module "eks" {

  source = "./modules/eks"


  project_name =
    local.name

  environment =
    var.environment

  vpc_id =
    module.vpc.vpc_id

  private_subnets =
    module.vpc.private_subnets

}


module "rds" {

  source = "./modules/rds"


  project_name =
    local.name

  vpc_id =
    module.vpc.vpc_id

  vpc_cidr =
    var.vpc_cidr

  private_subnets =
    module.vpc.private_subnets

  db_username =
    var.db_username

  db_password =
    var.db_password

}


module "s3" {

  source = "./modules/s3"


  project_name =
    local.name

}
