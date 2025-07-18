{ config, pkgs, ... }:
{
  # Bootloader.
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.default = "saved";
  boot.loader.grub.gfxmodeEfi = "1920x1080";
  boot.loader.grub.theme = pkgs.catppuccin-grub;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
