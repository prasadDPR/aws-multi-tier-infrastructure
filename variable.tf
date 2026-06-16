variable "private_key_path" {
  description = "Path to the SSH private key file"
  default     = "C:/Users/Dell/key/aws_bank_key.pem"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "key_name" {
  description = "AWS EC2 key pair name"
  type        = string
  default     = "aws_bank_key"
}