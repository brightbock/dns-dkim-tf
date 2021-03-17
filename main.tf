
data "aws_route53_zone" "zone_info" {
  name = var.route53_zone_name
}

locals {
  record_domain = var.dkim_domain == "" ? var.route53_zone_name : var.dkim_domain
}

resource "aws_route53_record" "dkim" {
  zone_id         = data.aws_route53_zone.zone_info.zone_id
  type            = "TXT"
  ttl             = var.dkim_ttl
  name            = "${var.dkim_selector}._domainkey.${local.record_domain}."
  allow_overwrite = true

  # The record needs to be split in to chunks < 256b long
  # resulting in one string like this: 'chunk" "chunk" "chunk'
  # (Terraform will add the outermost double-quotes to each element)

  records = [join("\" \"", compact([
    substr(var.dkim_record, 0, 220),
    substr(var.dkim_record, 220, 220),
    substr(var.dkim_record, 440, 220),
    substr(var.dkim_record, 660, 220),
    substr(var.dkim_record, 880, 220),
    substr(var.dkim_record, 1100, 220),
    substr(var.dkim_record, 1320, 220)
  ]))]
}

