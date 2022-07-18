resource "aws_acm_certificate" "checkip" {
  domain_name       = local.domain
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "checkip" {
  certificate_arn         = aws_acm_certificate.checkip.arn
  validation_record_fqdns = [aws_route53_record.checkip_certificate_validation.fqdn]
}
