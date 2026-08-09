output "vpc_id" {

  value =
    module.vpc.vpc_id

}


output "eks_cluster_name" {

  value =
    module.eks.cluster_name

}


output "eks_cluster_endpoint" {

  value =
    module.eks.cluster_endpoint

}


output "frontend_ecr" {

  value =
    module.ecr.frontend_repository_url

}


output "backend_ecr" {

  value =
    module.ecr.backend_repository_url

}


output "rds_endpoint" {

  value =
    module.rds.db_endpoint

}


output "s3_bucket" {

  value =
    module.s3.bucket_name

}
