{ inputs, ... }:
{
  flake.modules.nixos.host-vps = {
    imports = with inputs.self.modules.nixos; [
      base
      server
    ];

    nixpkgs.hostPlatform = "x86_64-linux";
    networking.useDHCP = true;
    time.timeZone = "America/New_York";
  };
}
