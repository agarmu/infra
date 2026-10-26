locals {
  web_records = {
    "@" = {
      CNAME = var.website_cname
    }
  }
}
