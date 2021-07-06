resource "aws_s3_bucket" "bucket_base_sate_tr" {
  bucket = "bucket-base-sate-tr-${data.aws_caller_identity.current.account_id}"
  acl    = "private"

  tags = {
    Name        = "bucket-base-sate-tr-${data.aws_caller_identity.current.account_id}"
    Environment = "admin"
  }
}
