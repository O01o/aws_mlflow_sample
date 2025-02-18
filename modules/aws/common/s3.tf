resource "aws_s3_bucket" "ml_bucket" {
  bucket = "${var.name}-ml-bucket"
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_notification" "ml_bucket_notifier" {
  bucket = aws_s3_bucket.ml_bucket.id
  eventbridge = true
}