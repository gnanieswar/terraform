

data "aws_ami" "amzon"{
 owners = ["998487421164"] 
 most_recent = true
 name_regex = "^taccoform-burrito-"
 
} 


data "template_file" "user_data_hw" {
  template = local.userdata

}
resource "aws_launch_template" "web" {
  name_prefix = "web-"

  image_id = data.aws_ami.amzon.id
  instance_type = "t2.micro"
  key_name = "ec2Key-dev"
  iam_instance_profile {
  name = aws_iam_instance_profile.this.name
  }

  #vpc_security_group_ids = [ "${aws_security_group.demosg.id}" ]
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [ "${aws_security_group.demosg.id}" ] 
  }
  user_data = "${base64encode(data.template_file.user_data_hw.rendered)}"

  lifecycle {
    create_before_destroy = true
  }
}