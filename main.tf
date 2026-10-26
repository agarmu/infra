module "dns" {
  source        = "./dns"
  website_cname = trimsuffix(data.vercel_domain_config.website.recommended_cname, ".")
}

module "storage" {
  source = "./storage"
}
