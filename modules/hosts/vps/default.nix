{ inputs, ... }:
{
  flake.modules.nixos.host-vps = {
    imports = with inputs.self.modules.nixos; [
      base
      server
    ];

    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.facter.reportPath = ./facter.json;
    networking.useDHCP = true;
    time.timeZone = "America/New_York";
  };
}
