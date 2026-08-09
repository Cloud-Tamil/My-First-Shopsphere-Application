resource "aws_s3_bucket" "products" {

  bucket =
    "${var.project_name}-product-images-${data.aws_caller_identity.current.account_id}"


  tags = {

    Project = var.project_name

  }

}


data "aws_caller_identity" "current" {}


resource "aws_s3_bucket_public_access_block" "products" {

  bucket =
    aws_s3_bucket.products.id


  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true

}


resource "aws_s3_bucket_server_side_encryption_configuration" "products" {

  bucket =
    aws_s3_bucket.products.id


  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"

    }

  }

}


variable "project_name" {

  type = string

}


output "bucket_name" {

  value =
    aws_s3_bucket.products.bucket

}


output "bucket_arn" {

  value =
    aws_s3_bucket.products.arn

}
