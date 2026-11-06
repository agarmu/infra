{
  flake.modules.nixos.server = {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "1h";
    };
    nix.optimise.automatic = true;

    # https://github.com/systemd/systemd/blob/main/tmpfiles.d/journal-nocow.conf#L8-L21
    systemd.tmpfiles.rules = [
      "h /var/log/journal - - - - +C"
      "h /var/log/journal/* - - - - +C"
    ];

    services.journald.settings.Journal = {
      Storage = "persistent";
      SystemMaxUse = "512M";
      MaxRetentionSec = "30day";
    };
  };
}
