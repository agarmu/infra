{
  flake.modules.nixos.host-vps =
    { lib, pkgs, ... }:
    {
      services.freshrss = {
        enable = true;
        package = pkgs.symlinkJoin {
          name = "freshrss-themed";
          paths = [
            pkgs.freshrss
            pkgs.freshrss-catppuccin
          ];
        };
        baseUrl = "https://rss.agarmu.com";
        webserver = "caddy";
        virtualHost = "rss.agarmu.com";
        defaultUser = "mukul";
        passwordFile = "/var/lib/freshrss/admin-password";
      };

      systemd.services.freshrss-config.preStart = ''
        # Autogenerate the initial password.
        if [ ! -s /var/lib/freshrss/admin-password ]; then
          umask 077
          ${pkgs.openssl}/bin/openssl rand -base64 32 > /var/lib/freshrss/admin-password
        fi

        install -Dm644 ${./config-user.custom.php} /var/lib/freshrss/config-user.custom.php
      '';

      services.phpfpm.pools.freshrss.settings = {
        "pm" = lib.mkForce "ondemand";
        "pm.max_children" = lib.mkForce 2;
        "pm.start_servers" = lib.mkForce 1;
        "pm.min_spare_servers" = lib.mkForce 1;
        "pm.max_spare_servers" = lib.mkForce 2;
        "pm.process_idle_timeout" = "10s";
      };
    };
}
