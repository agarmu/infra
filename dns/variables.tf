variable "website_cname" {
  description = "Recommended CNAME supplied by the Vercel domain configuration."
  type        = string
  nullable    = false
  validation {
    condition     = length(trimspace(var.website_cname)) > 0
    error_message = "Vercel must return a non-empty recommended CNAME."
  }
}
