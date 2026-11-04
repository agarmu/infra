{ inputs, ... }:
{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.host-vps = { pkgs, ... }: {
    imports = [ inputs.disko.nixosModules.disko ];
    environment.systemPackages = [ pkgs.btrfs-progs ];

    boot.loader.grub = {
      enable = true;
      efiSupport = false;
    };

    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0-0-0-0";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "1M";
            type = "EF02";
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountOptions = [ "compress=zstd:1" ];
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
