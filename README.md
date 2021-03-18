![GitHub](https://img.shields.io/github/license/brightbock/brightbock-dns-dkim-tf) ![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/brightbock/brightbock-dns-dkim-tf) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/brightbock/brightbock-dns-dkim-tf/Terraform)

# DKIM DNS records

This is a Terrafrom module to set DKIM DNS records in a Route53 zone.

## How to use:

1. Add a module definition to your Terraform. See the example below.
2. Update `route53_zone_name = ...` to match your zone name(s).
3. Update `dkim_selector = ...` to match your email provider
4. Update `dkim_record = ...` to match your email provider.
3. Optional: Uncomment and update the other example values to match your requirements.

```
module "example_dkim_dns" {
  source = "git::https://github.com/brightbock/brightbock-dns-dkim-tf.git?ref=v0.2.0"

  route53_zone_name = "example.com"

  dkim_selector = "google"

  ### Enter the whole record value here, without additional formatting
  dkim_record = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9DGDSFGSDFGSGAMIIBCgKCAQEAxjrIqHYPvCbRMUjLHGmY9jjwZ6Suqhd9+Z41rqjLFoDEmHcHTRo2HZeGu/91BAU+ZsOSDBSZ0I8KL+VTu6r1cCqY+GBHYjaAD/g+dBOFi/SJe+JmZySGO/4VVqfqlj0obGUKsa//JkIP7LlUhkDS5fdQ6WjeWv4AiexLw/Hn2xTYUCw31eJj5d6a/f1kHtWVKLJwo8hRu79++rMrLu3VCCLYdJV+b69Gk6sCyGOyGJmKbZcWSiyAn1L2M5LLU/yBKWIxeNO0gzeKxlShyM7k1RP5wLSwMkqEDfOsPCZOryswseb6P6HaR3E8Jt9Vk+VXofYd5mhbOKxtoKnr1/X/UwIDAQAB"

  ### The value of dkim_domain defaults to the value of `route53_zone_name`
  # dkim_domain = "subdomain.example.com"

  ### The DNS TTL defaults to 600 seconds
  # dkim_ttl = "600"

  ### You should not need to change the AWS region!
  # aws_region = "us-east-1"

}
```

### Note:

This module will overwrite corresponding records that already exist. Please take care to set appropriate values, before you apply.
