module "eks" {

  source = "terraform-aws-modules/eks/aws"

  version = "21.0.0"


  name = "${var.project_name}-eks"

  kubernetes_version = "1.33"


  endpoint_public_access = true

  endpoint_private_access = true


  enable_cluster_creator_admin_permissions = true


  vpc_id = var.vpc_id

  subnet_ids = var.private_subnets


  enable_irsa = true


  addons = {

    coredns = {

      most_recent = true

    }


    kube-proxy = {

      most_recent = true

    }


    vpc-cni = {

      most_recent = true

    }


    eks-pod-identity-agent = {

      most_recent = true

    }

  }


  eks_managed_node_groups = {

    default = {

      name = "${var.project_name}-nodes"


      instance_types = [
        "t3.medium"
      ]


      min_size = 2

      max_size = 3

      desired_size = 2


      subnet_ids =
        var.private_subnets


      capacity_type = "ON_DEMAND"

    }

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


variable "vpc_id" {

  type = string

}


variable "private_subnets" {

  type = list(string)

}


output "cluster_name" {

  value = module.eks.cluster_name

}


output "cluster_endpoint" {

  value = module.eks.cluster_endpoint

}


output "oidc_provider" {

  value = module.eks.oidc_provider

}
