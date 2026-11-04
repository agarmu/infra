{ inputs, ... }:
{
  flake-file.inputs.deploy-rs = {
    url = "github:serokell/deploy-rs";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.deploy.nodes.vps = {
    hostname = "vps.agarmu.com";
    sshUser = "mukul";
    interactiveSudo = true;

    # build on the remote, not locally
    remoteBuild = true;

    profiles.system = {
      user = "root";
      path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.vps;
    };
  };

  perSystem = { system, ... }: {
    checks = inputs.deploy-rs.lib.${system}.deployChecks inputs.self.deploy;
  };
}
