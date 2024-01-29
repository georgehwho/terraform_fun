locals {
  example_role_name   = "${local.app_pascal_case}Role"

  allow_bucket_access_policy_name = "${local.app_pascal_case}BucketPolicy"
}

resource "aws_iam_role" "ec2_s3_role" {
  name        = local.example_role_name
  description = "${local.app} role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "allow_bucket_access" {
  name        = local.allow_bucket_access_policy_name
  description = "Allow access to the ${local.app} bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:DeleteObject",
          "s3:Get*",
          "s3:List*",
          "s3:PutObject",
        ]
        Effect = "Allow"
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*",
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "example" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.allow_bucket_access.arn
}
