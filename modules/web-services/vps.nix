{
  flake.modules.nixos.host-vps = {
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
