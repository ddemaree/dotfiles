{
  ...
}:

{
  system.stateVersion = "25.11";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  imports = [
    # Machine-specific
    ./hardware-configuration.nix
    ./bootloader.nix
    ./nvidia.nix
    ./networking.nix
    ./power.nix

    # Shared
    ../shared/sound.nix
    ../shared/keyboard.nix
    ../shared/time.nix
    ../shared/nix-settings.nix
    # ../shared/usb.nix
    # ../shared/zram-swap.nix
    ../shared/i18n.nix
    ../shared/fonts.nix
    ../shared/theme.nix
    ../shared/security.nix
    ../shared/services.nix
    ../shared/hyprland.nix
    ../shared/dev-tools.nix
    ../shared/openssh.nix
    ../shared/vpn.nix
    ../shared/users.nix
    ../shared/llms.nix
    ../shared/virtualisation.nix
    ../shared/system-info.nix
    ./terminal.nix
  ];
}
