#creation of security group for alb

resource "aws_security_group" "samrdaymond_wa_alb_sg" {
  description = "weather app alb security group"
  vpc_id = aws_vpc.samrdaymond_wa_vpc.id
  ingress = [ {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Internet Web Traffic"
    from_port = 80
    to_port = 80
    protocol = "HTTP"    
  } ]
}
#creation of alb

resource "aws_lb" "samrdaymond_wa_alb" {
  name               = "weather-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = aws_security_group.samrdaymond_wa_alb_sg.id
  subnets            = [aws_subnet.samrdaymond_wa_public_sub_a.id, aws_subnet.samrdaymond_wa_public_sub_b.id]
  
  enable_deletion_protection = false
}
 
resource "aws_alb_target_group" "samrdaymond_alb_tg" {
  name        = "samrdaymond-weather-app-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.samrdaymond_wa_vpc.id
  target_type = "ip"


resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.samrdaymond_wa_alb.arn
  port              = 80
  protocol          = "HTTP"
 
  default_action {
   type = "forward"
   target_group_arn = aws_alb_target_group.samrdaymond_alb_tg.arn
  }
}

