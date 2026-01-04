{ config, pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared-linux.nix
  ];

  nix.settings.download-buffer-size = 128 * 1024 * 1024;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixon";
  networking.networkmanager.enable = true;

  # GNOME Desktop
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    xkb.layout = "us";
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter]
    experimental-features=['scale-monitor-framebuffer']

    [org.gnome.settings-daemon.plugins.power]
    sleep-inactive-ac-type='nothing'

    [org.gnome.desktop.remote-desktop.vnc]
    enable=true
    view-only=false
  '';

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # NVIDIA
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  # Autologin
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = user;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # System packages (GUI apps and things needing system integration)
  environment.systemPackages = with pkgs; [
    _1password-gui
    chromium
    google-chrome
    vscode
    code-cursor
    ghostty
    discord
    slack
    geekbench
    wget
    pciutils
    libsecret
    unzip
  ];

  system.stateVersion = "25.05";
}
