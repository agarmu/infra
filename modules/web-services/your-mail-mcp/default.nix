{ inputs, ... }:
{
  flake.modules.nixos.host-vps = {
    imports = [ inputs.self.modules.nixos.your-mail-mcp ];

    services.your-mail-mcp = {
      enable = true;
      host = "imap.purelymail.com";
      email = "newsletter@agarmu.com";
      domain = "mail-access.agarmu.com";
      passwordFile = "/var/lib/your-mail-mcp-secrets/imap-password";
    };
  };
}
