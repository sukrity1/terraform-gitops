resource "aws_route53_zone" "primary" {
  name = var.zone_name
}

resource "aws_route53_record" "main" {
  for_each = { for r in var.records : "${r.name}-${r.type}" => r }

  zone_id = aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.alias == null ? each.value.ttl : null
  records = each.value.alias == null ? each.value.records : null

  dynamic "alias" {
    for_each = each.value.alias != null ? [each.value.alias] : []
    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = alias.value.evaluate_target_health
    }
  }
}