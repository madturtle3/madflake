{ config, pkgs, ... }:
{
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    chezmoi # for the dots because I am done with this
    networkmanagerapplet
    kitty
    hyprpaper
    bibata-cursors
    waybar
    # waybar stuff
    pavucontrol
  ];
  fonts.packages =
    with pkgs;
    [
      nerd-fonts.symbols-only
      noto-fonts-color-emoji
    ];
}
