{ lib, inputs, ... }:
let
  inherit (inputs.self) modules;
  hostNames = builtins.filter (lib.hasPrefix "host-") (builtins.attrNames modules.nixos);
  mkNixos = moduleName: {
    name = lib.removePrefix "host-" moduleName;
    value = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        modules.nixos.${moduleName}
        {
          networking.hostName = lib.removePrefix "host-" moduleName;
          system.stateVersion = lib.mkDefault "26.05";
        }
      ];
    };
  };
in
{
  flake.nixosConfigurations = builtins.listToAttrs (map mkNixos hostNames);
}
