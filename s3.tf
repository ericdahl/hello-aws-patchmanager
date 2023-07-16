resource "aws_s3_bucket" "default" {
  bucket = "hello-aws-patchmanager"

  force_destroy = true
}