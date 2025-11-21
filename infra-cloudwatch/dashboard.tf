resource "aws_cloudwatch_dashboard" "sentiment_app" {
  dashboard_name = "${var.candidate_id}-sentiment-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x = 0
        y = 0
        width = 12
        height = 6
        properties = {
          metrics = [
            [var.cloudwatch_namespace, "sentiment.bedrock.duration.avg", "company", "Apple", "model" , "amazon.nova-micro-v1:0", { stat = "Average", label = "Apple Avg"}],
            [var.cloudwatch_namespace, "sentiment.bedrock.duration.avg", "company", "Microsoft", "model" , "amazon.nova-micro-v1:0", { stat = "Average", label = "Microsoft Avg"}],
            [var.cloudwatch_namespace, "sentiment.bedrock.duration.avg", "company", "Tesla", "model" , "amazon.nova-micro-v1:0", { stat = "Average", label = "Tesla Avg"}]
          ]
          period = 300
          stat = "Average"
          region = var.aws_region
          title = "Bedrock API Response Time by Company"
          yAxis = {
            left = {
              label = "Milliseconds"
            }
          }
        }
      },

      {
        type = "metric"
        x = 12
        y = 0
        width = 6
        height = 6
        properties = {
          metrics = [
            [var.cloudwatch_namespace, "sentiment.companies.detected.value", { stat = "Average", label = "Companies"}]
          ]
          period = 300
          stat = "Average"
          region = var.aws_region
          title = "Companies Detected"
          yAxis = {
            left = {
              label = "Count"
            }
          }
          view = "timeSeries"
        }
      },
      {
        type = "metric"
        x = 18
        y = 0
        width = 6
        height = 6
        properties = {
          metrics = [
            [var.cloudwatch_namespace, "sentiment.analysis.total.count", "company", "Apple", "sentiment", "POSITIVE" , { stat = "Sum", label = "Apple POSITIVE"}],
            [var.cloudwatch_namespace, "sentiment.analysis.total.count", "company", "Microsoft", "sentiment", "POSITIVE" , { stat = "Sum", label = "Microsoft POSITIVE"}],
            [var.cloudwatch_namespace, "sentiment.analysis.total.count", "company", "Tesla", "sentiment", "NEGATIVE" , { stat = "Sum", label = "Tesla NEGATIVE"}]
          ]
          period = 300
          stat = "Sum"
          region = var.aws_region
          title = "Total Sentiment Analyses by Company"
          yAxis = {
            left = {
              label = "Count"
            }
          }
        }
      },
      {
        type = "metric"
        x = 0
        y = 6
        width = 6
        height = 3
        properties = {
          metrics = [
            [var.cloudwatch_namespace, "sentiment.bedrock.duration.avg", "company", "Apple", "model" , "amazon.nova-micro-v1:0", { stat = "Average" }]
          ]
          period = 60
          stat = "Average"
          region = var.aws_region
          title = "Latest Bedrock Response Time"
          view = "singleValue"
        }
      }


    ]
  })
}