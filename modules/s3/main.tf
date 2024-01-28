locals {
  example_bucket_name      = var.bucket_name
  example_bucket_log_name  = "${var.bucket_name}_s3_logs"
}

# Create an S3 bucket
resource "aws_s3_bucket" "example" {
  bucket       = local.example_bucket_name
  force_destroy = false # Ensure Terraform doesn't delete the bucket if files are present
}

# Configure server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example.bucket

  rule {
    bucket_key_enabled = false
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Configure public access blocking for the S3 bucket
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Disable ACLs
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Configure logging for the S3 bucket
resource "aws_s3_bucket_logging" "example" {
  bucket       = aws_s3_bucket.example.id
  target_bucket = aws_s3_bucket.example.id
  target_prefix = "log/"
}

# Create a CloudTrail to capture S3 bucket access events
resource "aws_cloudtrail" "example_bucket_logs" {
  name                          = local.example_bucket_log_name
  s3_bucket_name                = aws_s3_bucket.example.id
  enable_logging                = true
  include_global_service_events = true
}
