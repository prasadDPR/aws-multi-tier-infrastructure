terraform {
  backend "s3" {
    bucket         = "prasad-terraform-state-2025"
    key            = "aws-multi-tier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}