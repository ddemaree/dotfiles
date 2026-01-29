{ pkgs, user, ... }:

{
  # Locale settings
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

  # Audio (pipewire)
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

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    noto-fonts-color-emoji
    nerd-fonts.caskaydia-mono
    recursive
  ];
  fonts.fontconfig.defaultFonts.emoji = [ "Noto Color Emoji" ];

  # User account
  users.users.${user} = {
    isNormalUser = true;
    description = "David Demaree";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
    shell = pkgs.fish;
  };

  users.defaultUserShell = pkgs.fish;
  security.sudo.wheelNeedsPassword = false;

  # System-level programs
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Common services
  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;

  environment.localBinInPath = true;

  environment.shellAliases = {
    la = "eza -la";
    ll = "eza -l";
  };

  virtualisation.containers.enable = true;
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };
}
