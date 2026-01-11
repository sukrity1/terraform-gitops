module "dns_records" {
  source    = "../modules/dns"
  zone_name = var.domain_name

  records = [
    // {
    //   name    = "api"
    //   type    = "A"
    //   records = ["10.0.0.50"]
    // },
    {
      name    = "web"
      type    = "CNAME"
      // records = ["alb-dns-name.aws.com"]
      records = [module.alb.alb_dns_name]
    }
  ]
}