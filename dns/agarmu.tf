locals {
  dns = {
    "agarmu.com" = {
      zone_id = "613d468a9eb29d7160b49cdea6fc881c"
      record_groups = [
        local.email_records,
        local.web_records,
        local.verification_records,
      ]
    }
  }
}
