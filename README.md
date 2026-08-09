# ShopSphere

Simple cloud-native e-commerce application running on AWS EKS.

## Architecture

- React frontend
- FastAPI backend
- PostgreSQL
- Docker
- Amazon ECR
- Amazon EKS
- Amazon RDS
- Amazon S3
- AWS ALB
- Terraform
- GitHub Actions

## Application Features

- Product listing
- Product details
- Shopping cart
- Checkout
- Order creation
- Order status

## AWS Infrastructure

Terraform provisions:

- VPC
- Public subnets
- Private subnets
- NAT Gateway
- EKS
- ECR
- RDS
- S3

## Local Development

Start the application:

```bash
docker compose up --build
