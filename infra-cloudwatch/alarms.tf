resource "aws_cloudwatch_metric_alarm" "bedrock_high_latency" {
  alarm_name = "${var.candidate_id}-bedrock-high-latency"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 2
  metric_name = "sentiment.bedrock.duration"
  namespace = var.cloudwatch_namespace
  period = 300
  statistic = "Average"
  threshold = var.alarm_threshold_duration_ms
  alarm_description = "Triggers when average Bedrock API response time has exceeded ${var.alarm_threshold_duration_ms}ms"
  treat_missing_data = "notBreaching"

  alarm_actions = [aws_sns_topic.cloudwatch_alarms.arn]
  ok_actions = [aws_sns_topic.cloudwatch_alarms.arn]

  tags = {
    Name = "${var.candidate_id}-bedrock-high-latency"
    Environment = "exam"
    Project = "AiAlpha"
  }
}