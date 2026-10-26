terraform {
  backend "s3" {
    bucket       = "agarmu-tfstate"
    key          = "dns/terraform.tfstate"
    region       = "auto"
    use_lockfile = true

    endpoints = {
      s3 = "https://45c37e9aa1980a793b7c7b2347f7dd07.r2.cloudflarestorage.com"
    }

    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}
