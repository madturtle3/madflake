{ config, pkgs, ... }:
{
  # BLE configuration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # Show battery charge of Bluetooth devices
      };
    };
  };
  services.blueman.enable = true;
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    chezmoi # for the dots because I am done with this
    networkmanagerapplet
    kitty
    hyprpaper
    bibata-cursors
    waybar
    rofi-wayland
    hyprlock
    hypridle
    pavucontrol
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    noto-fonts-color-emoji
  ];
}
