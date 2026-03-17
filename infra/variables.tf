variable "instance_type" {
  type        = string                     # The type of the variable, in this case a string
  description = "The type of EC2 instance" # Description of what this variable represents
}

variable "bucket_name" {
  type = string
  description = "Remote state bucket name"
}

variable "name" {
  type = string
  description = "Tag Name"
}

variable "environment" {
  type = string
  description = "Environment name"
}

variable "vpc_name" {
  type = string
  description = "Devops proj1 VPC name"
}

variable "vpc_cidr" {
  type = string
  description = "Devops Proj1 CIDR values"
}

variable "cidr_public_subnet" {
  type = list(string)
  description = "Public subnet CIDR values"
}

variable "cidr_private_subnet" {
  type = list(string)
  description = "Private subnet CIDR values"
}

variable "availability_zone" {
  type = list(string)
  description = "Availability Zones"
}

variable "public_key" {
  type = string
  description = "Devops Proj1 public key for EC2 instance"
}

variable "ami_id" {
  type = string
  description = "AMI ID for EC2 instance"
}

variable "ec2_user_data_install_apache" {
  type = string
  description = "Script for installing the Apache2"
}

variable "domain_name" {
  type = string
  description = "Name of domain"
}
