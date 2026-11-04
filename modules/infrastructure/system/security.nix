{
  flake.modules.nixos.server = {
    security.sudo.enable = false;
    security.sudo-rs.enable = false;
    security.run0 = {
      enable = true;
      wheelNeedsPassword = true;
      sudo-shim.enable = true;
    };

    networking.firewall.enable = true;

    # nonadmins do not have access to the nix daemon
    nix.settings.allowed-users = [
      "root"
      "@wheel"
    ];

    boot.kernel.sysctl = {
      # require privilege to read dmesg (kernel log)
      "kernel.dmesg_restrict" = 1;
      # hide kernel ptr addresses unless you have the correct rights
      "kernel.kptr_restrict" = 1;
      # block unprivileged users from loading BPF programs
      "kernel.unprivileged_bpf_disabled" = 1;
      # restrict ptrace to descendants or 'permitted' processes
      "kernel.yama.ptrace_scope" = 1;
    };
  };
}
