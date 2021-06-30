resource "aws_sns_topic" "sns_1" {
  name = "sns-1-topic"
}

resource "aws_sns_topic_subscription" "sns_1_email_target" {
  topic_arn              = aws_sns_topic.sns_1.arn
  protocol               = "email"
  endpoint               = var.EMAIL_ENDPOINT
  endpoint_auto_confirms = true
}

resource "aws_sqs_queue" "sqs_1" {
  name = "sqs-1-queue"
}

resource "aws_sns_topic_subscription" "sqs_1_sqs_target" {
  topic_arn = aws_sns_topic.sns_1.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs_1.arn
  endpoint_auto_confirms = true
}