{ config, pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared-linux.nix
    ../shared-gnome.nix
  ];

  nix.settings.download-buffer-size = 128 * 1024 * 1024;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixon";
  networking.networkmanager.enable = true;

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
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

  # System packages (nixon-specific)
  environment.systemPackages = with pkgs; [
    chromium
    pciutils
    libsecret
  ];

  system.stateVersion = "25.05";
}
