{
  flake.modules.nixos.base = { pkgs, ... }: {
    programs.git.enable = true;
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    environment.systemPackages = [ pkgs.jujutsu ];
    environment.variables.VISUAL = "nvim";
  };
}
