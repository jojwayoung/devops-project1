
module "networking" {
  source = "./networking"
  availability_zone   = var.availability_zone
  cidr_private_subnet = var.cidr_private_subnet
  cidr_public_subnet  = var.cidr_public_subnet
  vcp_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
}

module "security_group" {
  source = "./security-groups"
  ec2_sg_name = "SG for EC2 to enable SSH(22) and HTTP(80)"
  ec2_sg_name_for_python_api = "SG for EC2 for enabling port 5000"
  public_subnet_cidr_block = tolist(module.networking.public_subnet_cidr_block)
  vpc_id = module.networking.dev_proj1_vpc_id
}

module "ec2" {
  source = "./ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  tag_name = "Ubuntu Linux EC2"
  public_key = var.public_key
  subnet_id = tolist(module.networking.dev_proj1_public_subnets)[0]

  sg_enable_ssh_https = module.security_group.sg_ec2_sg_ssh_http_id
  ec2_sg_name_for_python_api = module.security_group.python_api_sg_id

  enable_public_ip_address = true
  user_data_install_apache = templatefile("./template/ec2_install_apache.sh", {})
}

module "lb_target_group" {
  source = "./load-balancer-target-group"
  lb_target_group_port = "5000"
  lb_target_group_protocol = "HTTP"
  ec2_instance_id = module.ec2.dev_proj1_ec2_instance_id
  vpc_id = module.networking.dev_proj1_vpc_id
  lb_target_group_name = "dev-proj1-lb-target-group"
}

module "alb" {
  source = "./load-balancer"
  ec2_instance_id                 = module.ec2.dev_proj1_ec2_instance_id
  lb_https_listener_port          = "443"
  lb_https_listener_protocol      = "HTTPS"
  lb_listener_default_action      = "forward"
  lb_listener_port                = 5000
  lb_listener_protocol            = "HTTP"
  is_external                     = false
  lb_name                         = "dev-proj1-alb"
  lb_target_group_arn             = module.lb_target_group.dev_proj1_lb_target_group_arn
  lb_target_group_attachment_port = 5000
  lb_type                         = "application"
  sg_enable_ssh_https             = module.security_group.sg_ec2_sg_ssh_http_id
  subnet_ids                      = tolist(module.networking.dev_proj1_public_subnets)
  tag_name                        = "dev-proj1-alb"
  dev_proj1_acm_arn               = module.aws_certification_manager.dev_proj1_acm_arn
}

module "hosted_zone" {
  source = "./hosted-zone"
  domain_name = var.domain_name
  aws_lb_dns_name = module.alb.aws_lb_dns_name
  aws_lb_zone_id = module.alb.aws_lb_zone_id
}

module "aws_certification_manager" {
  source = "./certificate-manager"
  domain_name = var.domain_name
  hosted_zone_id = module.hosted_zone.hosted_zone_id
}

module "rds_db_instance" {
  source = "./rds"
  db_subnet_group_name = "dev_proj1_rds_subnet_group"
  mysql_db_identifier = "mydb"
  mysql_dbname = "devprojdb"
  mysql_password = "dbpassword"
  mysql_username = "dbuser"
  rds_mysql_sg_id = module.security_group.rds_mysql_sg_id
  subnet_groups = tolist(module.networking.dev_proj1_public_subnets)
}
































