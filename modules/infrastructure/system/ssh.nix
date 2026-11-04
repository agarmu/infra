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
          MaxAuthTries = 3;
          LoginGraceTime = 30;
          X11Forwarding = false;
          LogLevel = "VERBOSE";
        };
      };

      services.fail2ban = {
        enable = true;
        maxretry = 5;
        bantime = "1h";
        bantime-increment = {
          enable = true;
          maxtime = "1w";
        };
        daemonSettings.Definition = {
          dbpurgeage = "30d";
          dbmaxmatches = 50;
        };
        jails.sshd.settings.findtime = "10m";
      };
    };
}
