resource "aws_s3_bucket" "data_lake" {
  bucket = "your-data-lake-bucket"
  acl    = "private"
  tags = {
    Name = "DataLakeBucket"
  }
}

resource "aws_s3_bucket_policy" "data_lake_policy" {
  bucket = aws_s3_bucket.data_lake.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ],
        Effect   = "Allow",
        Resource = [
          "${aws_s3_bucket.data_lake.arn}",
          "${aws_s3_bucket.data_lake.arn}/*"
        ],
        Principal = {
          AWS = aws_iam_role.sftp_role.arn
        }
      }
    ]
  })
}

output "bucket_name" {
  value = aws_s3_bucket.data_lake.bucket
}
