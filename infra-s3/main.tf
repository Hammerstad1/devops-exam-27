resource "aws_s3_bucket" "analysis" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
    Environment = "exam"
    Project = "AiAlpha"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.analysis.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}