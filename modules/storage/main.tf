locals {
  example_bucket_name = "${var.bucket_name}"
  example_bucket_log_name = "${var.bucket_name}_s3_logs"
}

resource "aws_s3_bucket" "example" {
  bucket = local.example_bucket_name

  # In case bucket is mission critical. Do not allow Terraform to delete it if there are still files in it.
  force_destroy = false
}


resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example.bucket
  rule {
    bucket_key_enabled = false
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning
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

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.example.id

  target_bucket = aws_s3_bucket.bucket.example.id
  target_prefix = "log/"
}

resource "aws_cloudtrail" "example_bucket_logs" {
  name                          = "${local.example_bucket_log_name}"
  s3_bucket_name                = aws_s3_bucket.example.id
  enable_logging                = true
  include_global_service_events = true
}
