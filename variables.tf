variable "route53_zone_name" {
  type        = string
  description = "The zone, as defined in AWS Route53"
}

// When dkim_domain is an empty string, the value 
// of `route53_zone_name` will be used.
variable "dkim_domain" {
  type    = string
  default = ""
}

variable "dkim_selector" {
  type        = string
  description = "The DKIM key selector e.g. \"selector\" for selector._domainkey.example.com"
  validation {
    condition = (
      length(split(".", var.dkim_selector)) == 1
    )
    error_message = "The selector value must not contain \".\"."
  }
}

variable "dkim_ttl" {
  type        = number
  description = "TTL to set on DNS record"
  default     = "600"
  validation {
    condition = (
      min(60, var.dkim_ttl) >= 60
    )
    error_message = "The dkim_ttl value must be >= 60."
  }
}

variable "dkim_record" {
  type        = string
  description = "The content of the DKIM record e.g. \"v=DKIM1; k=rsa; p=MIIBIjANBgk....\""
  default     = ""
  validation {
    condition = (
      (substr(var.dkim_record, 0, 6) == "v=DKIM") || (var.dkim_record == "")
    )
    error_message = "Please set dkim_record to a valid DKIM value."
  }
}

