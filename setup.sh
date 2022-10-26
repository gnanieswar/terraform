echo "Hello Sarav, How are you doing"
echo "Installing Apache2"
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y 
sudo systemctl enable nginx
sudo systemctl start nginx
sudo echo "Hello" | sudo tee /usr/share/nginx/html/index.html
 sudo cat  /usr/share/nginx/html/index.html