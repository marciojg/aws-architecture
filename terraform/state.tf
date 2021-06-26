terraform {
  backend "s3" {
    bucket = "bucket-base-sate-tr"
    key    = "key-state-workspace"
    region = "us-east-1"
  }
}