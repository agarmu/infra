{
  pkgs ? import <nixpkgs> { },
}:
let
  gitHooks = import (
    pkgs.fetchFromGitHub {
      owner = "cachix";
      repo = "git-hooks.nix";
      rev = "1ba1dbfe28738c9a71c266be6efa5b89e75491a9";
      hash = "sha256-VAhpCOmrun/KXimYfR8NM88bciKCui7CqHHhThSzgag=";
    }
  );
  preCommitCheck = gitHooks.run {
    src = ./.;
    # use prek instead of pre-commit (better perf)
    package = pkgs.prek;
    hooks = {
      # nix
      nixfmt.enable = true;
      # terraform/opentofu
      terraform-format = {
        enable = true;
        package = pkgs.opentofu;
      };
      terraform-validate = {
        enable = true;
        package = pkgs.opentofu;
      };
      # shell scripts
      shfmt = {
        enable = true;
        settings.indent = 2;
        settings.simplify = true;
      };
      shellcheck.enable = true;
      # markdown/docs
      mdformat.enable = true;
      # git
      check-merge-conflicts.enable = true;
      gitleaks.enable = true;
    };
  };
in
pkgs.mkShell {
  inherit (preCommitCheck) shellHook;
  packages = [
    pkgs.opentofu
    pkgs.just
  ]
  ++ preCommitCheck.enabledPackages;
}
