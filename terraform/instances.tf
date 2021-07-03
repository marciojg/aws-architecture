# Tópico SNS
resource "aws_sns_topic" "sns_1" {
  name = "sns-1-topic"
}

# Subscrição de email no SNS
resource "aws_sns_topic_subscription" "sns_1_email_target" {
  topic_arn              = aws_sns_topic.sns_1.arn
  protocol               = "email"
  endpoint               = var.EMAIL_ENDPOINT
  endpoint_auto_confirms = true
}

# Fila Morta do SQS (DLQ)
resource "aws_sqs_queue" "sns_sqs_dlq" {
  name              = "dlq-1-queue"
}

# Fila SQS
resource "aws_sqs_queue" "sqs_1" {
  name = "sqs-1-queue"
  visibility_timeout_seconds = 300
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sns_sqs_dlq.arn
    maxReceiveCount     = 2
  })
}

# Subscrição entre SNS e SQS
resource "aws_sns_topic_subscription" "sqs_1_sqs_target" {
  topic_arn = aws_sns_topic.sns_1.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs_1.arn
  raw_message_delivery = true
}

# Política de comunicação do SQS com SNS
resource "aws_sqs_queue_policy" "sqs_1_policy" {
    queue_url = "${aws_sqs_queue.sqs_1.id}"

    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_1.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.sns_1.arn}"
        }
      }
    }
  ]
}
POLICY
}

# Log Bucket S3
resource "aws_s3_bucket" "s3_bucket_final_log" {
  bucket = "s3-bucket-final-log"
  acl    = "log-delivery-write"
}

# Bucket S3
resource "aws_s3_bucket" "s3_bucket_final" {
  bucket = "s3-bucket-final"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.s3_bucket_final_log.id
    target_prefix = "log/"
  }
}
