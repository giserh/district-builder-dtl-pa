resource "aws_security_group" "app_server" {
  vpc_id = "${module.vpc.id}"

  name = "sgAppServer"

  tags {
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

data "aws_ami" "ecs_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app_server" {
  ami = "${data.aws_ami.ecs_ami.id}"

  disable_api_termination              = true
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "${var.app_server_instance_type}"
  key_name                             = "${var.aws_key_name}"
  monitoring                           = true
  availability_zone                    = "${var.app_server_availability_zone}"
  subnet_id                            = "${module.vpc.private_subnet_ids[0]}"
  vpc_security_group_ids               = ["${aws_security_group.app_server.id}"]

  tags {
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "app_server_alb" {
  vpc_id = "${module.vpc.id}"

  name = "sgALBAppServer"

  tags {
    Environment = "${var.environment}"
    Project     = "${var.project}"
  }
}

resource "aws_alb" "app_server" {
  name = "alb${var.environment}AppServer"

  security_groups = [
    "${aws_security_group.app_server_alb.id}",
  ]

  subnets = ["${module.vpc.public_subnet_ids}"]

  tags {
    Name        = "albAppServer"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_target_group" "app_server_http" {
  name = "tg${var.environment}HTTPAppServer"

  health_check {
    healthy_threshold   = "3"
    interval            = "60"
    matcher             = "200"
    protocol            = "HTTP"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  port     = "8080"
  protocol = "HTTP"
  vpc_id   = "${module.vpc.id}"

  tags {
    Name        = "tg${var.environment}HTTPAppServer"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_alb_target_group_attachment" "app_server" {
  target_group_arn = "${aws_alb_target_group.app_server_http.arn}"
  target_id        = "${aws_instance.app_server.id}"
  port             = 8080
}

resource "aws_alb_listener" "api_server_http" {
  load_balancer_arn = "${aws_alb.app_server.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.app_server_http.id}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "api_server_https" {
  load_balancer_arn = "${aws_alb.app_server.id}"
  port              = "443"
  protocol          = "HTTPS"

  certificate_arn = "${var.ssl_certificate_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.app_server_http.id}"
    type             = "forward"
  }
}
