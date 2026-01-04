{ config, pkgs, user, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-amd-ai-300-series-nvidia
    ./hardware-configuration.nix
    ../shared-linux.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "framewerk";
  networking.networkmanager.enable = true;

  # X11/Wayland
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # GNOME Desktop
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # NVIDIA (Framework-specific)
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    prime = {
      amdgpuBusId = "PCI:195:0:0";
      nvidiaBusId = "PCI:194:0:0";
    };
  };

  # User packages (Framework-specific)
  users.users.${user}.packages = with pkgs; [
    kdePackages.kate
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    bibata-cursors
  ];

  # Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # GNOME tweaks
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/mutter" = {
          experimental-features = [
            "scale-monitor-framebuffer"
            "variable-refresh-rate"
            "xwayland-native-scaling"
          ];
        };
      };
    }
  ];

  system.stateVersion = "25.11";
}
