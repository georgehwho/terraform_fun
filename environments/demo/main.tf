# environments/dev/main.tf
provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source = "../../modules/s3"

  # Customize S3 bucket variables for dev environment
  bucket_name = "your-dev-s3-bucket"
}

module "asg" {
  source = "../../modules/ec2_core"

  # Customize ASG variables for dev environment
  desired_capacity     = 3
  max_size             = 5
  min_size             = 1
  subnet_ids           = ["subnet-xxxxxx", "subnet-yyyyyy"] # Add your subnet IDs
  s3_bucket_arn        = module.s3_bucket.bucket_arn
}
