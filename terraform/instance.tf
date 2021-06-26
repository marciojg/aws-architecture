resource "aws_sns_topic" "sns_1" {
  name = "sns-1-topic"
}

resource "aws_sns_topic_subscription" "sns_1_email_target" {
  topic_arn              = aws_sns_topic.sns_1.arn
  protocol               = "email"
  endpoint               = var.EMAIL_ENDPOINT
  endpoint_auto_confirms = true
}