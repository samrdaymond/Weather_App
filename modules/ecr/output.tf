output "ecr_repo_url" {
  description = "URL of the ECR repo"
  value       = aws_ecr_repository.ecr.repository_url
}