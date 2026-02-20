{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.david = {
    isNormalUser = true;
    description = "demaree";
    extraGroups = [
      "networkmanager"
      "input"
      "wheel"
      "video"
      "audio"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
      pear-desktop
      google-chrome
      firefox-devedition
      discord
      slack
      obsidian
      _1password-gui
      inputs.polypane.packages.x86_64-linux.polypane
    ];
  };

  # Change runtime directory size
  services.logind.settings.Login = {
    RuntimeDirectorySize = "8G";
  };
}
