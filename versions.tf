terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 5.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.28"
    }
  }
}

# Reads CLOUDFLARE_API_TOKEN from the environment.
provider "cloudflare" {}

# Reads VERCEL_API_TOKEN from the environment.
provider "vercel" {}
