pkgs:
let
  callPackage = pkgs.lib.callPackageWith pkgs;
in
{
  freshrss-catppuccin = callPackage ./freshrss-catppuccin { };
  your-mail-mcp = callPackage ./your-mail-mcp { };
}
