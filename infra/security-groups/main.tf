variable "ec2_sg_name" {}
variable "vpc_id" {}
variable "public_subnet_cidr_block" {}
variable "ec2_sg_name_for_python_api" {}


output "sg_ec2_sg_ssh_http_id" {
  value = aws_security_group.ec2_sg_ssh_http.id
}

output "rds_mysql_sg_id" {
  value = aws_security_group.rds_mysql_sg.id
}

output "python_api_sg_id" {
  value = aws_security_group.ec2_python_api_sg.id
}


resource "aws_security_group" "ec2_sg_ssh_http" {
  name = var.ec2_sg_name
  description = "Enable Port 22(SSH) and 80(HTTP)"
  vpc_id = var.vpc_id

  # ssh(22) for terraform remote exec
  ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  # enable http(80)
  ingress {
    description = "Allow remote HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  # enable https(443)
  ingress {
    description = "Allow remote HTTPS request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }

  # outgoing request
  egress {
    description = "Allow outgoing request"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Groups to allow SSH(22), HTTP(80) and HTTPS(443)"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_mysql_sg" {
  name = "rds-sg"
  description = "Allow access to RDS from EC2 present in public subnet"
  vpc_id = var.vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = var.public_subnet_cidr_block # Replace with your EC2 Instance security group CIDR block
  }
}

resource "aws_security_group" "ec2_python_api_sg" {
  name = var.ec2_sg_name_for_python_api
  description = "Enable Port 5000 for python api"
  vpc_id = var.vpc_id

  # SSH for terraform remote exec
  ingress {
    description = "Allow traffic on port 5000"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
  }

  tags = {
    Name = "Security Groups to allow traffic on port 5000"
  }
}
