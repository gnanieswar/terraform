resource "aws_autoscaling_group" "web" {
  name = "${aws_launch_template.web.name}-asg"

  min_size             = 2
  desired_capacity     = 2
  max_size             = 4
  #health_check_type         = "EC2"
   health_check_type    = "ELB"
  load_balancers = [
    "${aws_elb.web_elb.id}"
  ]
  

  launch_template  {
      id      = "${aws_launch_template.web.id}"
      version = aws_launch_template.web.latest_version
    }
    
 



  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier  = [
    "${var.subnet_DDP-QA-Web-Zone}",
    "${var.subnet_DDP-QA-Web-Zone-2}"
  ]

  # Required to redeploy without an outage.
  #lifecycle {
  #  create_before_destroy = true
  #}

  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
   instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

}
