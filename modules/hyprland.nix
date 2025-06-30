{config,pkgs,...}:
{
	programs.hyprland.enable=true;
	environment.systemPackages = with pkgs; [
		kitty
		hyprpaper
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
  fonts.packages = with pkgs; [
  nerd-fonts.symbols-only
  noto-fonts-color-emoji
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
