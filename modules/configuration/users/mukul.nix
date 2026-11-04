{
  flake.modules.nixos.base = { pkgs, ... }: {
    users.users.mukul = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTXhKaRv6Ejh+ecUdR/MiJcucu048MsK6aO8AzPSHlB mukul@mukul-mbp"
      ];
    };
  };
}
