resource "aws_elb" "web_elb" {
  name = "web-elb"
  security_groups = [aws_security_group.elb_http.id]
  subnets = [var.subnet_DDP-QA-Web-Zone,var.subnet_DDP-QA-Web-Zone-2]
  cross_zone_load_balancing   = true

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }

}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.web.id
  elb                    = aws_elb.web_elb.id
}

#IP of aws instance copied to a file ip.txt in local system


output "elb_dns_name" {
  value = aws_elb.web_elb.dns_name
}