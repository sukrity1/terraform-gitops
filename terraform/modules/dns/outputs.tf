# 1. The ID of the Hosted Zone (essential for adding more records later)
output "zone_id" {
  description = "The ID of the Hosted Zone"
  value       = aws_route53_zone.primary.zone_id
}

# 2. The Name Servers (important for updating your domain registrar)
output "name_servers" {
  description = "The name servers for the hosted zone"
  value       = aws_route53_zone.primary.name_servers
}

# 3. All created record FQDNs (useful for health checks or testing)
output "record_fqdns" {
  description = "A list of all FQDNs created"
  value       = { for k, v in aws_route53_record.main : k => v.fqdn }
}

# 4. Specific FQDN lookup (optional, but very helpful)
# This allows you to do: module.dns_records.fqdns["api-A"]
output "fqdns" {
  description = "Map of record keys to their FQDNs"
  value       = { for k, v in aws_route53_record.main : k => v.fqdn }
}