{
  config,
  pkgs,
  user,
  inputs,
  ...
}:

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-amd-ai-300-series-nvidia
    ./hardware-configuration.nix
    ../shared-linux.nix
    ../shared-gnome.nix
    ../shared-hyprland.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Plymouth boot splash
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";

  networking.hostName = "framewerk";
  networking.networkmanager.enable = true;

  # NVIDIA (Framework-specific)
  hardware.nvidia = {
    nvidiaSettings = true;
    prime = {
      amdgpuBusId = "PCI:195:0:0";
      nvidiaBusId = "PCI:194:0:0";
    };
  };

  # System packages (framewerk-specific)
  environment.systemPackages = with pkgs; [
    dnsmasq
    ddev
    nil
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;

  # Required services
  security.polkit.enable = true;

  system.stateVersion = "25.11";
}
