# environments/dev/main.tf
provider "aws" {
  region = "us-east-2"
}

module "asg" {
  source = "../modules/asg"

  # Customize ASG variables for dev environment
  desired_capacity     = 3
  max_size             = 5
  min_size             = 1
  subnet_ids           = ["subnet-xxxxxx", "subnet-yyyyyy"] # Add your subnet IDs
}

module "iam" {
  source = "../modules/iam"

  # Customize IAM variables for dev environment
  s3_bucket_name = "your-dev-s3-bucket"
}

module "s3_bucket" {
  source = "../modules/s3_bucket"

  # Customize S3 bucket variables for dev environment
  bucket_name = "your-dev-s3-bucket"
}

module "security_group" {
  source = "../modules/security_group"

  # Customize security group variables for dev environment
  # ...
}
