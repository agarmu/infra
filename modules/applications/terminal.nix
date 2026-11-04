{
  flake.modules.nixos.server = { pkgs, ... }: {
    programs.tmux.enable = true;
    # terminal descriptions for SSH sessions
    environment.systemPackages = [
      pkgs.ghostty.terminfo
      pkgs.alacritty.terminfo
    ];
  };
}
