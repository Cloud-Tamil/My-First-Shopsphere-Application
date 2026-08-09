resource "aws_ecr_repository" "frontend" {

  name = "${var.project_name}/frontend"

  image_tag_mutability = "MUTABLE"


  image_scanning_configuration {

    scan_on_push = true

  }


  tags = {

    Project = var.project_name

  }

}


resource "aws_ecr_repository" "backend" {

  name = "${var.project_name}/backend"

  image_tag_mutability = "MUTABLE"


  image_scanning_configuration {

    scan_on_push = true

  }


  tags = {

    Project = var.project_name

  }

}


variable "project_name" {

  type = string

}


output "frontend_repository_url" {

  value =
    aws_ecr_repository.frontend.repository_url

}


output "backend_repository_url" {

  value =
    aws_ecr_repository.backend.repository_url

}
