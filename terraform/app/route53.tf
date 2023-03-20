data "aws_route53_zone" "checkip" {
  name         = local.domain
  private_zone = false
}

resource "aws_route53_record" "checkip" {
  zone_id = data.aws_route53_zone.checkip.id
  name    = local.domain
  type    = "A"

  alias {
    name                   = aws_api_gateway_domain_name.checkip.cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.checkip.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "checkip_certificate_validation" {
  for_each = {
    for options in aws_acm_certificate.checkip.domain_validation_options : options.domain_name => {
      name  = options.resource_record_name
      type  = options.resource_record_type
      value = options.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.checkip.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = 60
}
