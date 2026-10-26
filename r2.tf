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
