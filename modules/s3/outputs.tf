output "main_bucket_id" {
  description = "The ID of the main S3 bucket"
  value       = aws_s3_bucket.example.id
}

output "cloudtrail_id" {
  description = "The ID of the CloudTrail"
  value       = aws_cloudtrail.example.id
}
