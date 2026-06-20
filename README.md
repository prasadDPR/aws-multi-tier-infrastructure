# AWS Infrastructure Automation — Terraform & GitHub Actions

> Complete production-grade multi-tier AWS environment provisioned from zero to live in under 10 minutes with a single code push.

---

## Architecture Diagram

![Hosting in AWS](https://github.com/prasadDPR/cicd-aws-project/assets/121819069/9356c818-bbfa-49f3-b595-9101582deeb7)

---

## Overview

This project automates the deployment of a production-grade multi-tier AWS infrastructure using Terraform and GitHub Actions. Every resource is defined as code — fully reproducible, version controlled, and automatically deployed on every push.

**No manual AWS Console changes. No configuration drift. No state conflicts.**

---

## Infrastructure Components

| Layer | Resource | Details |
|---|---|---|
| Network | VPC | Custom VPC with public and private subnets |
| Network | NAT Gateway | Outbound internet access for private resources |
| Network | Internet Gateway | Public internet access for public subnet |
| Network | Route Tables | Separate routing for public and private subnets |
| Compute | EC2 + Auto Scaling | Launch templates with dynamic AMI selection |
| Compute | Application Load Balancer | Health checks, target groups, listener rules |
| Database | RDS MySQL | Private subnet, restricted security group access |
| CDN | CloudFront | Global content delivery with S3 error pages |
| Storage | S3 | Static assets and custom error pages |
| DNS | Route 53 | Domain routing and DNS management |
| Security | ACM | SSL/TLS certificate management |
| Security | Security Groups | Least-privilege inbound and outbound rules |
| Security | IAM | Least-privilege roles for all resources |
| State | S3 Backend | Remote Terraform state storage |
| State | DynamoDB | State locking for concurrent operations |

---

## CI/CD Pipeline

Every code push triggers the following automated pipeline:

```
Code Push → GitHub Actions → Terraform Init → Terraform Plan → Terraform Apply → Infrastructure Live
```

**Pipeline features:**
- Automatic Terraform plan on every pull request
- Automatic apply on merge to main branch
- Remote state management via S3 backend
- DynamoDB state locking prevents concurrent conflicts
- Dynamic AMI selection — always uses latest approved image
- Secure variable management via GitHub Actions secrets

---

## Security Architecture

- All compute resources deployed in **private subnets**
- Database tier isolated with **restricted security groups**
- No direct SSH access — managed via AWS Systems Manager
- **Least-privilege IAM roles** attached to all resources
- SSL/TLS termination via **ACM certificates**
- CloudFront enforces **HTTPS-only** traffic

---

## Prerequisites

- AWS account with appropriate permissions
- Terraform >= 1.0 installed
- GitHub repository with Actions enabled
- S3 bucket for Terraform remote state
- DynamoDB table for state locking

---

## Quick Start

**1. Clone the repository**
```bash
git clone https://github.com/prasadDPR/aws-multi-tier-infrastructure.git
cd aws-multi-tier-infrastructure
```

**2. Configure variables**
```bash
cp variable.tf.example variable.tf
# Edit variable.tf with your values
```

**3. Initialise Terraform**
```bash
terraform init
```

**4. Preview changes**
```bash
terraform plan
```

**5. Deploy infrastructure**
```bash
terraform apply
```

Or simply push to main branch and let GitHub Actions handle it automatically.

---

## Remote State Configuration

State is managed remotely using S3 and DynamoDB:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "multi-tier/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

---

## GitHub Actions Workflow

The pipeline is defined in `.github/workflows/` and performs:

- **On Pull Request** — runs `terraform plan` and posts results as PR comment
- **On Push to Main** — runs `terraform apply` automatically
- **On All Branches** — runs `terraform validate` and `terraform fmt`

---

## Tech Stack

**Infrastructure:** AWS VPC, EC2, RDS, ALB, CloudFront, S3, Route 53, ACM
**IaC:** Terraform
**CI/CD:** GitHub Actions
**State Management:** S3 + DynamoDB

---

## Author

**Prasad Dhakshinamoorthi**
Cloud & DevOps Engineer
