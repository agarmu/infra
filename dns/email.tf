# Purelymail Email
locals {
  email_records = {
    "@" = {
      MX = {
        main = {
          content  = "mailserver.purelymail.com"
          priority = 50
        }
      }
      TXT = {
        purelymail = {
          content = format("\"purelymail_ownership_proof=%s\"", join("", [
            "350a21cd1a34c16013a152d8c5727cf63ed0c9e291977a4b",
            "d6bcf88d04543367a0a92dfed645c4540dc8620c30ae02f0",
            "baccf5916161fd5f958f345d3fbe05dd",
          ]))
        }
        spf = {
          content = "\"v=spf1 include:_spf.purelymail.com ~all\""
        }
      }
    }
    "_dmarc" = {
      CNAME = "dmarcroot.purelymail.com"
    }
    "purelymail1._domainkey" = {
      CNAME = "key1.dkimroot.purelymail.com"
    }
    "purelymail2._domainkey" = {
      CNAME = "key2.dkimroot.purelymail.com"
    }
    "purelymail3._domainkey" = {
      CNAME = "key3.dkimroot.purelymail.com"
    }
  }
}
