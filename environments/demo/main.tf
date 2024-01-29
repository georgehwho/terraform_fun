provider "aws" {
  region = "us-east-1"
}

module "s3_bucket" {
  source = "../../modules/s3"

  bucket_name = "your-dev-s3-bucket"
}

module "asg" {
  source = "../../modules/ec2_core"

  desired_capacity     = 3
  max_size             = 5
  min_size             = 1
  subnet_ids           = ["subnet-xyz", "subnet-xyz"] # pretend these subnet ID are real
  s3_bucket_arn        = module.s3_bucket.bucket_arn
}
