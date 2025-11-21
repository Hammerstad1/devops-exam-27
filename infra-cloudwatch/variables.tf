variable "aws_region" {
  description = "AWS region"
  type = string
  default = "eu-west-1"
}

variable "candidate_id" {
  description = "Candidate ID"
  type = string
  default = "kandidat-27"
}

variable "cloudwatch_namespace" {
  description = "CloudWatch namespace for metrics"
  type = string
  default = "kandidat27"
}

variable "alarm_email" {
  description = "Email address for alerts"
  type = string
}

variable "alarm_threshold_duration_ms" {
  description = "Threshold for average Bedrock duration"
  type = number
  default = 5000
}