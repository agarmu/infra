{
  flake.modules.nixos.vps = {
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
