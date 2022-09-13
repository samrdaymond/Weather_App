module "s3_bucket" {
  source = "./modules/s3"
  bucket = var.bucket

  tags = var.tags
}

module "vpc" {
  source = "./modules/vpc"
  #pass variables here (I have set defaults for demonstration purposes)
}

module "ecs" {
  source = "./modules/ecs"
  #pass variables here (I have set defaults for demonstration purposes)
}

module "alb" {
  source = "./modules/alb"
  #pass variables here (I have set defaults for demonstration purposes)
}

output "bucket_name" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name}"]
}

output "bucket_name_arn" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name_arn}"]
}