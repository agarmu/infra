{
  flake.modules.nixos.base = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Find and inspect files.
      fd
      ripgrep
      tree
      bat

      # Inspect structured data.
      jq
      yq

      # Monitor system resources.
      htop
      btop
      sysstat # iostat, pidstat, mpstat, sar
      iotop # Disk I/O by process
      iftop # Network traffic by connection
      # disk usage/freenes
      ncdu
      duf
      dust

      lsof # open files/sockets

      # Networking and file transfers.
      curl
      dig
      mtr
      tcpdump
      rsync
      wget

      # Create and extract archives.
      gnutar
      gzip
      zip
      unzip
    ];
  };
}
