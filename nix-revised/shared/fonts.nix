{ pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [
    adwaita-fonts
    geist-font
    jetbrains-mono
    inter
    ibm-plex
    mona-sans
    font-awesome
    nerd-font-patcher
    noto-fonts-color-emoji
    nerd-fonts.caskaydia-mono
    recursive
  ];

  fonts.fontconfig.defaultFonts.emoji = [ "Noto Color Emoji" ];
}
