resource "aws_s3_bucket" "bucket_base" {
  bucket = "bucket-base-sate-tr"
  acl    = "private"

  tags = {
    Name        = "bucket-base-sate-tr"
    Environment = "admin"
  }
}