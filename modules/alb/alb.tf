#creation of alb next week


#create security group for alb
resource "aws_security_group" "weather-app-alb-sg" {
  description = "weather-app-alb-sg"
  vpc_id = aws_vpc.samrdaymond_wa_vpc.id
  ingress = [ {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Internet Web Traffic"
    from_port = 80
    to_port = 80
    protocol = "HTTP"    
  } ]
}