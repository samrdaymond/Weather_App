output "samrdaymond_wa_alb_sgid" {
    value = aws_security_group.samrdaymond_wa_alb_sg.id
}

output "samrdaymond_wa_aws_alb_tg_arn" {
  value = aws_alb_target_group.samrdaymond_alb_tg.arn
}

output "samrdaymond_wa_alb_dns_name" {
  value       = aws_lb.samrdaymond_wa_alb.dns_name
}