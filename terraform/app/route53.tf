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
  zone_id = data.aws_route53_zone.checkip.zone_id
  name    = aws_acm_certificate.checkip.domain_validation_options.*.resource_record_name[0]
  type    = aws_acm_certificate.checkip.domain_validation_options.*.resource_record_type[0]
  records = [aws_acm_certificate.checkip.domain_validation_options.*.resource_record_value[0]]
  ttl     = 60
}
