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
  samrdaymond_wa_alb_sgid = module.alb.samrdaymond_wa_alb_sgid
  samrdaymond_wa_aws_alb_tg_arn = module.alb.samrdaymond_wa_aws_alb_tg_arn
  samrdaymond_wa_public_sub_aid = module.vpc.samrdaymond_wa_public_sub_aid
  samrdaymond_wa_public_sub_bid = module.vpc.samrdaymond_wa_public_sub_bid
}

module "alb" {
  source = "./modules/alb"
  samrdaymond_wa_vpcid = module.vpc.samrdaymond_wa_vpcid
  samrdaymond_wa_public_sub_aid = module.vpc.samrdaymond_wa_public_sub_aid
  samrdaymond_wa_public_sub_bid = module.vpc.samrdaymond_wa_public_sub_bid
}

output "bucket_name" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name}"]
}

output "bucket_name_arn" {
  description = "The name of the bucket"
  value       = ["${module.s3_bucket.s3_bucket_name_arn}"]
}