variable "domain_name" {}
variable "aws_lb_dns_name" {}
variable "aws_lb_zone_id" {}

output "hosted_zone_id" {
  value = data.aws_route53_zone.dev_proj1_dev-jwayoung-cloud.zone_id
}

data "aws_route53_zone" "dev_proj1_dev-jwayoung-cloud" {
  name = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "lb_record" {
  name    = var.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.dev_proj1_dev-jwayoung-cloud.zone_id

  alias {
    evaluate_target_health = true
    name                   = var.aws_lb_dns_name
    zone_id                = var.aws_lb_zone_id
  }
}


