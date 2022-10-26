#! /bin/bash
set -e

# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data-extra -s 2>/dev/console) 2>&1
yum update -y
yum upgrade -y

# Configure Cloudwatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
rpm -U ./amazon-cloudwatch-agent.rpm

mkdir -p /usr/share/collectd/
touch /usr/share/collectd/types.db

# Use cloudwatch config from SSM
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c ssm:${ssm_cloudwatch_config} -s



# Make sure we have all the latest updates when we launch this instance



sudo amazon-linux-extras install epel -y
sudo yum install stress -y



