terraform {
  backend "s3" {
    bucket = "bucket-base-sate-tr-<ACCOUNT-ID-AQUI>"
    key    = "key-state-workspace"
    region = "us-east-1"
  }
}
