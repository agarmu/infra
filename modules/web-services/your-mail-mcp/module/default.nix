{
  flake.modules.nixos.your-mail-mcp =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.services.your-mail-mcp;
      stateDir = "/var/lib/your-mail-mcp";
      listenAddress = "127.0.0.1:${toString cfg.listenPort}";
      accounts = (pkgs.formats.json { }).generate "your-mail-mcp-accounts.json" {
        accounts = [
          {
            name = "mailbox";
            inherit (cfg) host port;
            user = cfg.email;
            tls = "imaps";
            pass_cmd = "${pkgs.coreutils}/bin/cat \"$CREDENTIALS_DIRECTORY/imap-password\"";
            patterns = [ "*" ];
            exclude_folders = [ ];
          }
        ];
      };
    in
    {
      config = lib.mkIf cfg.enable {
        services.caddy = {
          enable = true;
          virtualHosts.${cfg.domain}.extraConfig = ''
            reverse_proxy ${listenAddress} {
              # mcp sdk requires host
              header_up Host {upstream_hostport}
            }
          '';
        };
        systemd.services.your-mail-mcp = {
          description = "your-mail-mcp";
          wantedBy = [ "multi-user.target" ];
          wants = [ "network-online.target" ];
          after = [ "network-online.target" ];
          environment = {
            # mbsync needs the statedir
            HOME = stateDir;
            CONFIG = accounts;
            MAILDIR = "${stateDir}/mail";
            INDEX = "${stateDir}/index";
            PUBLIC_URL = "https://${cfg.domain}";
            LISTEN_ADDR = listenAddress;
            INIT_MIRROR = "1";
            SYNC_INTERVAL = cfg.syncInterval;
            SYNC_TIMEOUT = cfg.syncTimeout;
          };
          preStart = ''
            mkdir -p "${stateDir}/mail" "${stateDir}/index"
            test -s "$CREDENTIALS_DIRECTORY/imap-password"
            if [ ! -s "${stateDir}/oauth-passphrase" ]; then
              umask 077
              ${pkgs.openssl}/bin/openssl rand -base64 32 > "${stateDir}/oauth-passphrase"
            fi
          '';
          script = ''
            export OAUTH_PASSPHRASE="$(cat "${stateDir}/oauth-passphrase")"
            exec ${lib.getExe cfg.package} serve
          '';
          serviceConfig = {
            Restart = "on-failure";
            RestartSec = "10s";
            DynamicUser = true;
            StateDirectory = "your-mail-mcp";
            StateDirectoryMode = "0700";
            WorkingDirectory = stateDir;
            LoadCredential = [
              "imap-password:${cfg.passwordFile}"
            ];
            UMask = "0077";
            CapabilityBoundingSet = "";
            PrivateTmp = true;
            PrivateDevices = true;
            RestrictAddressFamilies = [
              "AF_UNIX"
              "AF_INET"
              "AF_INET6"
            ];
          };
        };
      };
    };
}
