output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_subnet_id_first" {
  value = aws_subnet.private01.id
}

output "vpc_subnet_id_second" {
  value = aws_subnet.private02.id
}

output "bucket_id" {
  value = aws_s3_bucket.ml_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.ml_bucket.arn
}