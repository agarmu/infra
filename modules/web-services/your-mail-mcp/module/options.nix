{
  flake.modules.nixos.your-mail-mcp =
    { lib, pkgs, ... }:
    let
      runtimeSecret = lib.types.addCheck lib.types.str (
        path: lib.hasPrefix "/" path && !lib.hasPrefix "/nix/store/" path
      );
    in
    {
      options.services.your-mail-mcp = {
        enable = lib.mkEnableOption "your-mail-mcp";
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.your-mail-mcp;
          description = "package providing your-mail-mcp";
        };
        host = lib.mkOption {
          type = lib.types.str;
          description = "IMAP Server Hostname";
        };
        port = lib.mkOption {
          type = lib.types.port;
          default = 993;
          description = "IMAP server port";
        };
        email = lib.mkOption {
          type = lib.types.str;
          description = "Email address used to log in to the IMAP server.";
        };
        passwordFile = lib.mkOption {
          type = runtimeSecret;
          description = "Absolute path to a file containing the IMAP password";
        };
        domain = lib.mkOption {
          type = lib.types.strMatching "[A-Za-z0-9][A-Za-z0-9.-]*";
          description = "Public hostname for the MCP endpoint.";
        };
        listenPort = lib.mkOption {
          type = lib.types.port;
          default = 8090;
          description = "HTTP Port to listen on";
        };
        syncInterval = lib.mkOption {
          type = lib.types.str;
          default = "10m";
          description = "Frequency of mailbox sync.";
        };
        syncTimeout = lib.mkOption {
          type = lib.types.str;
          default = "1h";
          description = "Time limit for each mailbox sync.";
        };
      };
    };
}
