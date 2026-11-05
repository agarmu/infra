{ inputs, ... }:
{
  imports = [
    inputs.flake-file.flakeModules.default
    inputs.flake-parts.flakeModules.modules
  ];

  systems = [
    "x86_64-linux"
    "aarch64-darwin" # needed to run write-flake
  ];

  flake-file = {
    description = "my nixos configurations";
    outputs = "inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)";
    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      flake-parts = {
        url = "github:hercules-ci/flake-parts";
        inputs.nixpkgs-lib.follows = "nixpkgs";
      };
      flake-file.url = "github:denful/flake-file";
      import-tree.url = "github:denful/import-tree";
    };
  };

  flake.modules.nixos.base = { pkgs, ... }: {
    nix.package = pkgs.lix;
    nixpkgs.overlays = [ (final: _: import ../../pkgs final) ];

    programs.nh.enable = true;

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  perSystem = { pkgs, ... }: {
    packages = import ../../pkgs pkgs;
  };
}
