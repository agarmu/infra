{
  flake.modules.nixos.server = {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "1h";
    };
    nix.optimise.automatic = true;

    services.journald.settings.Journal = {
      Storage = "persistent";
      SystemMaxUse = "512M";
      MaxRetentionSec = "30day";
    };
  };
}
