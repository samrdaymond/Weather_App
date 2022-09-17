output "samrdaymond_wa_vpcid" {
  value = aws_vpc.samrdaymond_wa_vpc.id
}

output  "samrdaymond_wa_public_sub_aid" {
  value = aws_subnet.samrdaymond_wa_public_sub_a.id
}

output  "samrdaymond_wa_public_sub_bid" {
  value = aws_subnet.samrdaymond_wa_public_sub_b.id
}