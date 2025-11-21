resource "aws_sns_topic" "cloudwatch_alarms" {
  name = "${var.candidate_id}-cloudwatch-alarms"
  display_name = "CloudWatch Alarms for ${var.candidate_id}"

  tags = {
    Name = "${var.candidate_id}-cloudwatch-alarms"
    Environment = "exam"
    Project = "AiAlpha"
  }
}

resource "aws_sns_topic_subscription" "alarm_email" {
  topic_arn = aws_sns_topic.cloudwatch_alarms.arn
  protocol = "email"
  endpoint = var.alarm_email
}