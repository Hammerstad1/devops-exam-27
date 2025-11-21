output "dashboard_url" {
  description = "URL to the CloudWatch Dashboard"
  value       = "https://console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards:name=${aws_cloudwatch_dashboard.sentiment_app.dashboard_name}"
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic for alarms"
  value       = aws_sns_topic.cloudwatch_alarms.arn
}

output "alarm_name" {
  description = "Name of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.bedrock_high_latency.alarm_name
}