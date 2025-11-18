output "bucket_name" {
  description = "Name of the created S3 bucket"
  value = aws_s3_bucket.analysis.bucket
}

output "bucket_region" {
  description = "Region of the bucket"
  value = var.aws_region
}

output "lifecycle_rule_id" {
  description = "Lifecycle rule id used for temporary files"
  value = aws_s3_bucket_lifecycle_configuration.analysis_lifecycle.rule[0].id
}