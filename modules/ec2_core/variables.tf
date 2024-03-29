variable "desired_capacity" {
  description = "The desired number of EC2 instances in the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "The maximum number of EC2 instances in the Auto Scaling Group"
  type        = number
}

variable "min_size" {
  description = "The minimum number of EC2 instances in the Auto Scaling Group"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs in which the instances will be launched"
  type        = list(string)
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
}

# could add more variables here to add more customization to the the modules but for the sake of take home I'll leave it minimal.
