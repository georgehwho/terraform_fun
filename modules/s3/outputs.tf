output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.example.arn
}

output "cloudtrail_id" {
  description = "The ID of the CloudTrail"
  value       = aws_cloudtrail.example.id
}
