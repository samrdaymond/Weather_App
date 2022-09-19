#creation of security group for alb

resource "aws_security_group" "samrdaymond_wa_alb_sg" {
  description = "weather app alb security group"
  vpc_id = var.samrdaymond_wa_vpcid
  ingress = [ {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Internet Web Traffic"
    from_port = 80
    to_port = 80
    protocol = "HTTP"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  } ]
}
#creation of alb

resource "aws_lb" "samrdaymond_wa_alb" {
  name               = "weather-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.samrdaymond_wa_alb_sg.id]
  subnets            = [var.samrdaymond_wa_public_sub_aid, var.samrdaymond_wa_public_sub_bid]
  enable_deletion_protection = false
}
 
#creation of alb target group
resource "aws_alb_target_group" "samrdaymond_alb_tg" {
  name        = "samrdaymond-weather-app-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.samrdaymond_wa_vpcid
  target_type = "ip"
}

#creation fo listerner for alb
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.samrdaymond_wa_alb.arn
  port              = 80
  protocol          = "HTTP"
 
  default_action {
   type = "forward"
   target_group_arn = aws_alb_target_group.samrdaymond_alb_tg.arn
  }
}

