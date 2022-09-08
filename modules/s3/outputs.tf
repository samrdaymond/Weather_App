output "s3_bucket_name" {
  description = "The name of the bucket"
  value       = aws_s3_bucket.weatherappbucket.id
}

output "s3_bucket_name_arn" {
  description = "The AWS ARN of the bucket"
  value       = aws_s3_bucket.weatherappbucket.arn
}