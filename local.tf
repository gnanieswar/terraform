locals {
  userdata = templatefile("userdata.sh", {
    ssm_cloudwatch_config = aws_ssm_parameter.cw_agent.name
  })
}
locals {
  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
}