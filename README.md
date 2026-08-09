# ShopSphere

A simple cloud-native e-commerce application, built to run on AWS EKS.

---

## Overview

ShopSphere is a learning/reference project that walks through building a full e-commerce stack — frontend, backend, database, and infrastructure — and deploying it to AWS using containers, Kubernetes, and Infrastructure as Code.

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | React |
| Backend | FastAPI |
| Database | PostgreSQL |
| Containerization | Docker |
| Container Registry | Amazon ECR |
| Orchestration | Amazon EKS |
| Managed Database | Amazon RDS |
| Object Storage | Amazon S3 |
| Load Balancing | AWS ALB |
| Infrastructure as Code | Terraform |
| CI/CD | GitHub Actions |

## Application Features

- Product listing
- Product details
- Shopping cart
- Checkout
- Order creation
- Order status tracking

## AWS Infrastructure

Terraform provisions the following:

- VPC
- Public subnets
- Private subnets
- NAT Gateway
- EKS cluster
- ECR repositories
- RDS instance
- S3 bucket

---

## Local Development

Start the full stack locally with Docker Compose:

```bash
docker compose up --build
```

- Frontend: [http://localhost:8080](http://localhost:8080)
- Backend API docs: [http://localhost:8000/docs](http://localhost:8000/docs)

## Infrastructure Deployment (Terraform)

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Kubernetes Deployment

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/secrets.yaml
kubectl apply -f k8s/backend/
kubectl apply -f k8s/frontend/
kubectl apply -f k8s/ingress.yaml
```

## CI/CD Pipeline

```
GitHub → Build → Docker → Amazon ECR → Amazon EKS
```

GitHub Actions builds the Docker images, pushes them to Amazon ECR, and rolls out the update to the Amazon EKS cluster.

---

## ⚠️ A Note Before Deploying to Production

The setup above is fine for a learning MVP, but **one thing should not be carried into production as-is**:

```
Kubernetes Secret → DB_PASSWORD
```

Storing the database password directly as a raw Kubernetes Secret works for local experimentation, but it isn't how a production system should manage credentials.

**Production-ready secrets flow:**

```
AWS Secrets Manager
        │
        ▼
External Secrets Operator
        │
        ▼
Kubernetes Secret
        │
        ▼
Backend Pod
```

Similarly, proper IAM permissions are needed for the ALB integration:

```
EKS
 └── AWS Load Balancer Controller
          └── ALB
```

This requires additional Terraform/IAM configuration (IRSA or Pod Identity) beyond the basic setup.

---

## Final Target Architecture

Once all phases are complete, the system will look like this:

```
                         INTERNET
                            │
                            ▼
                        Route 53
                            │
                            ▼
                           ALB
                            │
                            ▼
                     ┌─────────────┐
                     │     EKS     │
                     │             │
                     │ ┌─────────┐ │
                     │ │Frontend │ │
                     │ │  Pods   │ │
                     │ └────┬────┘ │
                     │      │      │
                     │ ┌────▼────┐ │
                     │ │ Backend │ │
                     │ │  Pods   │ │
                     │ └────┬────┘ │
                     └──────┼──────┘
                            │
              ┌─────────────┼─────────────┐
              │             │             │
              ▼             ▼             ▼
             RDS            S3      Secrets Manager
          PostgreSQL   Product Images   DB Secrets
```

**CI/CD flow:**

```
Developer
    │
    ▼
  GitHub
    │
    ▼
GitHub Actions
    │
    ├─────────────┐
    ▼             ▼
   ECR           EKS
    │             │
    ├─ Frontend   ├─ Frontend Pods
    └─ Backend    └─ Backend Pods
```

---

## Recommended Build Order

Don't provision everything at once — build and validate it in stages:

| Step | Task |
|---|---|
| 1 | Create GitHub repository |
| 2 | Build FastAPI backend and React frontend |
| 3 | Docker Compose — test locally |
| 4 | Terraform: VPC, ECR, RDS, S3, EKS |
| 5 | Push frontend & backend images to ECR |
| 6 | Deploy AWS Load Balancer Controller and Kubernetes manifests |
| 7 | Configure ALB and access the app from a browser |
| 8 | Wire up Secrets Manager + External Secrets Operator |
| 9 | Set up GitHub Actions CI/CD |
| 10 | Add observability: CloudWatch, Prometheus, Grafana |

> **Note:** Avoid copying all Kubernetes/Terraform files at once and running `terraform apply` blindly. EKS, the AWS Load Balancer Controller, IAM/IRSA (or Pod Identity), RDS security groups, and the current supported Kubernetes version all need to be wired together correctly — provider and module APIs evolve, so building this in a controlled sequence avoids partial deployments and unexpectedly expensive dangling resources.

**Next step:** Start with Phase 1 — get the React + FastAPI + PostgreSQL app running locally with Docker Compose. Once that's solid, move the same application to ECR and EKS rather than rewriting it.
