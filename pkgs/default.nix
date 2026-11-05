pkgs:
let
  callPackage = pkgs.lib.callPackageWith pkgs;
in
{
  your-mail-mcp = callPackage ./your-mail-mcp { };
}
