
# terraform {
#   backend "s3" {
#     bucket         = "XXXXXXXXXXXXXXXXXXXXXX"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-state-lock"
#   }
# }

# # DynamoDB table for state locking
# resource "aws_dynamodb_table" "terraform_state_lock" {
#   name           = "terraform-state-lock"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# # S3 bucket for storing terraform state
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "XXXXXXXXXXXXXXXXXXXXXX"
# }

# # Enable versioning on the S3 bucket
# resource "aws_s3_bucket_versioning" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Enable server-side encryption for the S3 bucket
# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }