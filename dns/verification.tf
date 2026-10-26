locals {
  verification_records = {
    "@" = {
      TXT = {
        # Google site ownership verification
        google = {
          content = "\"google-site-verification=JihgGpsxk_mEoppXH2SRFSkHc_EhHEYNopH2v0B-nkI\""
          ttl     = 3600
        }
      }
    }
  }
}
