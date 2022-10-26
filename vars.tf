# Defining Public Key
variable "public_key" {
  default = "tests.pub"
}

# Defining Private Key
variable "private_key" {
  default = "tests.pem"
}

# Definign Key Name for connection
variable "key_name" {
  default = "tests"
  description = "Name of AWS key pair"
}

# Defining CIDR Block for VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Defining CIDR Block for Subnet
variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

# Defining CIDR Block for 2d Subnet
variable "subnet1_cidr" {
  default = "10.0.2.0/24"
}
variable "vpc_id" {
  default = "vpc-090148d5341944c8c"
}
variable "subnet_DDP-QA-Web-Zone" {
  default = "subnet-0e3a103644d5f2150"
}
variable "subnet_DDP-QA-Web-Zone-2" {
  default = "subnet-09cf9025872089d77"
}