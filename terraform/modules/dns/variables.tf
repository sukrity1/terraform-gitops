variable "zone_name" {
  description = "The name of the hosted zone (e.g. example.com)"
  type        = string
}

variable "records" {
  description = "A list of records to create"
  type = list(object({
    name    = string
    type    = string
    ttl     = optional(number, 300)
    records = optional(list(string))
    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = bool
    }))
  }))
  default = []
}