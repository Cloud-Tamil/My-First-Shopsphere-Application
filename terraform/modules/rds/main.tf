resource "aws_db_subnet_group" "this" {

  name =
    "${var.project_name}-db-subnet-group"

  subnet_ids =
    var.private_subnets


  tags = {

    Name =
      "${var.project_name}-db-subnet-group"

  }

}


resource "aws_security_group" "rds" {

  name =
    "${var.project_name}-rds-sg"

  description =
    "Security group for ShopSphere RDS"

  vpc_id =
    var.vpc_id


  ingress {

    description =
      "PostgreSQL"

    from_port = 5432

    to_port = 5432

    protocol = "tcp"

    cidr_blocks = [
      var.vpc_cidr
    ]

  }


  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

}


resource "aws_db_instance" "this" {

  identifier =
    "${var.project_name}-postgres"


  engine = "postgres"

  engine_version = "16"


  instance_class =
    "db.t3.micro"


  allocated_storage = 20

  storage_type = "gp3"


  db_name = "shopsphere"

  username = var.db_username

  password = var.db_password


  port = 5432


  db_subnet_group_name =
    aws_db_subnet_group.this.name


  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]


  publicly_accessible = false


  skip_final_snapshot = true

  deletion_protection = false


  backup_retention_period = 1


  tags = {

    Project = var.project_name

  }

}


variable "project_name" {

  type = string

}


variable "vpc_id" {

  type = string

}


variable "vpc_cidr" {

  type = string

}


variable "private_subnets" {

  type = list(string)

}


variable "db_username" {

  type = string

}


variable "db_password" {

  type = string

  sensitive = true

}


output "db_endpoint" {

  value =
    aws_db_instance.this.address

}


output "db_port" {

  value =
    aws_db_instance.this.port

}
