resource "aws_ecr_repository" "samrdaymond_wa_repo" {
    name = "samrdaymond_node_weather_app"
    image_tag_mutability = "MUTABLE"
    
    image_scanning_configuration {
    scan_on_push = true
    }
}

output "ecr_name" {
  value = aws_ecr_repository.samrdaymond_wa_repo.name
}