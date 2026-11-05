{
  flake.modules.nixos.host-vps =
    { lib, pkgs, ... }:
    {
      services.freshrss = {
        enable = true;
        baseUrl = "https://rss.agarmu.com";
        webserver = "caddy";
        virtualHost = "rss.agarmu.com";
        defaultUser = "mukul";
        passwordFile = "/var/lib/freshrss/admin-password";
      };

      # autogenerate password
      systemd.services.freshrss-config.preStart = ''
        if [ ! -s /var/lib/freshrss/admin-password ]; then
          umask 077
          ${pkgs.openssl}/bin/openssl rand -base64 32 > /var/lib/freshrss/admin-password
        fi
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
