locals {
  r2_buckets = {
    state    = "agarmu-tfstate"
    cms      = "cms"
    cms-demo = "cms-demo"
  }
}

resource "cloudflare_r2_bucket" "buckets" {
  for_each   = local.r2_buckets
  account_id = "45c37e9aa1980a793b7c7b2347f7dd07"
  name       = each.value

  lifecycle {
    prevent_destroy = true
  }
}

locals {
  r2_cors = {
    cms = [
      {
        allowed = {
          origins = ["https://ui.cms.agarmu.com"]
          methods = ["GET", "HEAD", "PUT", "POST"]
          headers = ["*"]
        }
        expose_headers = ["ETag"]
      },
      {
        allowed = {
          origins = ["https://agarmu.com", "https://www.agarmu.com"]
          methods = ["GET", "HEAD"]
        }
      },
    ]
    cms-demo = [
      {
        allowed = {
          origins = ["https://ui.cms.agarmu.com"]
          methods = ["GET", "HEAD"]
        }
      },
    ]
  }
}

resource "cloudflare_r2_bucket_cors" "buckets" {
  for_each    = local.r2_cors
  account_id  = cloudflare_r2_bucket.buckets[each.key].account_id
  bucket_name = cloudflare_r2_bucket.buckets[each.key].name
  rules       = each.value
}
