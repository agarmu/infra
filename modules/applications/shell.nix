{
  flake.modules.nixos.base = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };
    programs.zoxide.enable = true;
    programs.fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };
    environment.shellAliases = {
      ll = "ls -lah";
      ports = "ss -tulpn";
      failed = "systemctl --failed";
    };
  };
}
