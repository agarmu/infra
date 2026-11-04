{
  flake.modules.nixos.server =
    { config, ... }:
    {
      assertions = [
        {
          assertion = config.users.users.root.openssh.authorizedKeys.keys != [ ];
          message = "Add your SSH public key to modules/infrastructure/system/server.nix before installation.";
        }
      ];
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "prohibit-password";
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };
      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbJlVq+tN1td+zjV+F4Na3kbHlhA1+TlJG7UgQMHdwV mukul@Mukuls-MacBook-Pro.local"
      ];
    };
}
