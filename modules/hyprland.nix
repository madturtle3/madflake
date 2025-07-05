{ config, pkgs, inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.default ];
  home-manager = {
    users = {
      "mason" = {
        xdg.configFile = {
          hypr = {
            source = ../config/hypr;
            recursive = true;
          };
          kitty = {
            source = ../config/kitty;
            recursive = true;
          };
          waypaper = {
            source = ../config/waypaper;
            recursive = true;
          };
          waybar = {
            source = ../config/waybar;
            recursive = true;
          };
        };
      };
    };
  };
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    kitty
    hyprpaper
    waypaper
    # for a theme I want to use
    foot
    dunst
    swaybg
    eww
    wofi
    waybar
    # waybar stuff
    pavucontrol
    yay
  ];
  fonts.packages =
    with pkgs;
    [
      nerd-fonts.symbols-only
      noto-fonts-color-emoji
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
