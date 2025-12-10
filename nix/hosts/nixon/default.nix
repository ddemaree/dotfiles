{ config, pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixon";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # GNOME Desktop
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    videoDrivers = [ "nvidia" ];
    xkb.layout = "us";
  };

  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
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

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # User account
  users.users.${user} = {
    isNormalUser = true;
    description = "David Demaree";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  users.defaultUserShell = pkgs.zsh;
  security.sudo.wheelNeedsPassword = false;

  # Autologin
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = user;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # System-level programs
  programs.zsh.enable = true;  # Basic enablement, config moves to Home Manager
  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  nixpkgs.config.allowUnfree = true;

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

  # Services
  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;

  services.ollama = {
    enable = true;
    loadModels = [ "gpt-oss:20b" "gpt-oss:120b-cloud" "deepseek-r1:1.5b" ];
    acceleration = "cuda";
  };

  services.open-webui.enable = true;

  system.stateVersion = "25.05";
}
