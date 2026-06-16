terraform {
  backend "s3" {
    bucket         = "yourname-terraform-state"
    key            = "aws-multi-tier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}