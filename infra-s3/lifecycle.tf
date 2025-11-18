resource "aws_s3_bucket_lifecycle_configuration" "analysis_lifecycle" {
  bucket = aws_s3_bucket.analysis.id

  rule {
    id = "temporary-files-lifecycle"
    status = "Enabled"

    filter {
      prefix = var.temp_prefix
    }

    transition {
      days = var.transition_days
      storage_class = "GLACIER"
    }

    expiration {
      days = var.expiration_days
    }

  }

}