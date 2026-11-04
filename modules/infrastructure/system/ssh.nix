{
  flake.modules.nixos.server =
    { config, ... }:
    {
      assertions = [
        {
          assertion = config.users.users.mukul.openssh.authorizedKeys.keys != [ ];
          message = "Configure an SSH public key for mukul before deploying.";
        }
      ];
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };
    };
}
