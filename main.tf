module "s3_bucket" {
  source = "./modules/s3"
  bucket = var.bucket
}

module "vpc" {
  source = "./modules/vpc"
  
}

module "ecs" {
  source = "./modules/ecs"
  samrdaymond_wa_vpcid = module.vpc.samrdaymond_wa_vpcid
}

module "alb" {
  source = "./modules/alb"
  samrdaymond_wa_vpcid = module.vpc.samrdaymond_wa_vpcid
}

output "bucket_name" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name}"]
}

output "bucket_name_arn" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name_arn}"]
}