{ config, pkgs, user, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-amd-ai-300-series-nvidia
    ./hardware-configuration.nix
    ../shared-linux.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelParams = [
    "quiet"
    "loglevel=3"
  ];

  # Plymouth boot splash
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";

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
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # services.desktopManager.plasma6.enable = true;
  # services.desktopManager.cosmic.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # NVIDIA (Framework-specific)
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    prime = {
      amdgpuBusId = "PCI:195:0:0";
      nvidiaBusId = "PCI:194:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  # User packages (Framework-specific)
  users.users.${user}.packages = with pkgs; [
    kdePackages.kate
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    dnsmasq
    gnome-tweaks
    bibata-cursors
    gnomeExtensions.pop-shell
    fuzzel             # launcher
    waybar             # status bar
    dunst              # notifications
    hyprlock           # lockscreen
    hypridle           # idle daemon
    hyprpaper          # wallpaper
    wl-clipboard       # clipboard
    grim               # screenshots
    slurp              # region selection
    pavucontrol        # audio control
    networkmanagerapplet
    fastfetch
    btop
    davinci-resolve
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Required services
  security.polkit.enable = true;

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
        "org/gnome/shell" = {
          enabled-extensions = [
            "pop-shell@system76.com"
          ];
        };
      };
    }
  ];

  system.stateVersion = "25.11";
}
