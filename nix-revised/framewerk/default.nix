{
  ...
}:

{
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ./bootloader.nix
    ./nvidia.nix
    ../shared/sound.nix
    # ../shared/usb.nix
    ../shared/keyboard.nix
    ../shared/time.nix
    ../shared/nix-settings.nix
    # ../shared/zram-swap.nix
  ];
}
