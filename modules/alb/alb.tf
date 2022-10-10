/*Create appliction load balancer security group*/
resource "aws_security_group" "alb" {
  name        = "terraform_alb_security_group"
  description = "Terraform load balancer security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags ={
    Name = "terraform-example-alb-security-group"
  }
}

//####################################################
//# Application Load balancer
//####################################################

resource "aws_alb" "alb" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.alb.id}"]
  subnets            = var.public_subnet_ids
  tags ={
    Name = "terraform-alb"
  }
}


# Target Group Creation

resource "aws_alb_target_group" "tg" {
  name        = "ALB-TargetGroup"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}

//# Target Group Attachment with Instance
//####################################################
//
//resource "aws_alb_target_group_attachment" "tgattachment" {
//
//  target_group_arn = aws_alb_target_group.tg.arn
//  target_id        = module.ec2.app_server_id
//  port             = 80
//
//}



####################################################
# Listner
####################################################

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.tg.arn
    type             = "forward"


  }
}

//####################################################
//# Record set in Route 53
//####################################################
//resource "aws_route53_record" "terraform" {
//  zone_id = data.aws_route53_zone.zone.zone_id
//  name    = "terraform.${var.route53_hosted_zone_name}"
//  type    = "A"
//  alias {
//    name                   = aws_alb.alb.dns_name
//    zone_id                = aws_alb.alb.zone_id
//    evaluate_target_health = true
//  }
//}

####################################################
# Listener Rule
####################################################

resource "aws_alb_listener_rule" "static" {
  listener_arn = aws_alb_listener.listener_http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg.arn

  }

  condition {
    path_pattern {
      values = ["/var/www/html/index.html"]
    }
  }
}