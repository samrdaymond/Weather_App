#creation of VPC endpoint for S3 bucket
resource "aws_vpc_endpoint" "samrdaymond_wa_s3_endpoint" {
  vpc_id = aws_vpc.var.vpc_name.id
  service_name = "com.amazonaws.ap-southeast-2.s3"
}

#associate s3 endpoint with route tables
resource "aws_vpc_endpoint_route_table_association" "samrdaymond_wa_vpcrtassoc_private_a" {
  route_table_id = aws_route_table.samrdaymond_wa_private_rt_a.id
  vpc_endpoint_id = aws_vpc_endpoint.samrdaymond_wa_s3_endpoint.id
}
resource "aws_vpc_endpoint_route_table_association" "samrdaymond_wa_vpcrtassoc_private_b" {
  route_table_id = aws_route_table.samrdaymond_wa_private_rt_a.id
  vpc_endpoint_id = aws_vpc_endpoint.samrdaymond_wa_s3_endpoint.id
}
resource "aws_vpc_endpoint_route_table_association" "samrdaymond_wa_vpcrtassoc_private_c" {
  route_table_id = aws_route_table.samrdaymond_wa_private_rt_a.id
  vpc_endpoint_id = aws_vpc_endpoint.samrdaymond_wa_s3_endpoint.id
}