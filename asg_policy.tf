resource "aws_autoscaling_policy" "web_policy_up" {
  name = "web_policy_up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = "${aws_autoscaling_group.web.name}"
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name = "web_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "60"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.web.name}"
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ "${aws_autoscaling_policy.web_policy_up.arn}" ]
}





resource "aws_cloudwatch_metric_alarm" "web_mem_alarm_up" {
  

  alarm_name = "web_mem_alarm_up-mem-available-percent-alert"
  #for_each                  = toset(data.aws_instances.test.ids)

  metric_name         = "mem_used_percent" # The metric name as reported by the CloudWatch Agent.
  namespace           = "CWAgent" # The namespace for the CloudWatch Agent.
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"
  treat_missing_data  = "notBreaching"
  insufficient_data_actions = [ ]
  

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.web.name}"
      #InstanceId = each.value
     #InstanceType = "t2.micro"
    #ImageId = "ami-01216e7612243e0ef"
  }
actions_enabled = true
  alarm_description = "This metric monitor EC2 instance mem utilization"
  alarm_actions = [ "${aws_autoscaling_policy.web_policy_up.arn}" ]
}


#data "aws_instances" "test" {
  #instance_tags = {
  # "aws:autoscaling:groupName" = "web-20221009172817101700000004-asg"
  #}

  #instance_state_names = ["running"]
#}

#output ids {
 #   value = data.aws_instances.test.ids
#}

resource "aws_cloudwatch_metric_alarm" "web_mem_alarm_down" {
 alarm_description = "Available memory for web_mem_alarm_up is below 20 percent."

  alarm_name = "web_mem_alarm_down-mem-available-percent-alert"

  metric_name         = "mem_used_percent" # The metric name as reported by the CloudWatch Agent.
  namespace           = "CWAgent" # The namespace for the CloudWatch Agent.
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  period              = "60"
  statistic           = "Minimum"
  threshold           = "10"
  treat_missing_data  = "notBreaching"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.web.name}" # The name of the Autoscaling Group.
  }

  alarm_actions = [
    "${aws_autoscaling_policy.web_policy_down.arn}",
  ]
}



resource "aws_autoscaling_policy" "web_policy_down" {
  name = "web_policy_down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 60
  autoscaling_group_name = "${aws_autoscaling_group.web.name}"
}

#resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
 # alarm_name = "web_cpu_alarm_down"
  #comparison_operator = "LessThanOrEqualToThreshold"
  #evaluation_periods = "2"
  #metric_name = "CPUUtilization"
  #namespace = "AWS/EC2"
  #period = "60"
  #statistic = "Average"
  #threshold = "10"

  #dimensions = {
   # AutoScalingGroupName = "${aws_autoscaling_group.web.name}"
  #}

  #alarm_description = "This metric monitor EC2 instance CPU utilization"
  #alarm_actions = [ "${aws_autoscaling_policy.web_policy_down.arn}" ]
#}
